pragma Singleton

import Quickshell
import Quickshell.Io
import QtQml

import qs.assets

Singleton {
    id: root

    readonly property string station: "Montreal-Trudeau"
    property real temperature: NaN
    property real humidity: NaN
    property string lastUpdated: ""
    property int weatherCode: -1
    property int cloudCover: -1
    property bool isDay: false
    property url icon: Assets.weather.clearDay

    function normalizeCloudCover(code) {
        // Aviation codes: 0=clear, 1=FEW(1-2 oktas), 2=SCT(3-4), 3=BKN(5-7), 4=OVC(8)
        if (code === 0)
            return 0;
        if (code === 1)
            return 2;
        if (code === 2)
            return 4;
        if (code === 3)
            return 6;
        if (code === 4)
            return 8;
        // SYNOP codes: 32=1 okta, 33=2, ..., 39=8 oktas
        if (code >= 32 && code <= 39)
            return code - 31;
        // Sky clear (manned) or NSC
        if (code === 42 || code === 43)
            return 0;
        // Sky obscured or obscured significance
        if (code === 40 || code === 44)
            return 8;
        return -1;
    }

    function parseValue(xml, name) {
        const rx = new RegExp('name="' + name + '"[^>]*value="([^"]*)"');
        const m = xml.match(rx);
        return m ? parseFloat(m[1]) : NaN;
    }

    function parseWeather(xml) {
        root.temperature = parseValue(xml, "air_temp");
        root.humidity = parseValue(xml, "rel_hum");

        const t = xml.match(/valid-time="([^"]+)"/);
        if (t) {
            root.lastUpdated = t[1];
        }

        const codeMatch = xml.match(/code-type="present_weather"[^>]*value="(\d+)"/);
        root.weatherCode = codeMatch ? parseInt(codeMatch[1]) : -1;

        const cloudMatch = xml.match(/code-type="total_cloud_amount"[^>]*value="(\d+)"/);
        root.cloudCover = cloudMatch ? normalizeCloudCover(parseInt(cloudMatch[1])) : -1;

        const h = new Date().getHours();
        root.isDay = h >= 6 && h < 20;
        root.icon = Assets.weather.getIcon(root.weatherCode, root.isDay, root.cloudCover);
    }

    Process {
        id: fetchProcess
        command: ["curl", "-s", "https://dd.weather.gc.ca/today/observations/swob-ml/latest/CYUL-MAN-swob.xml"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.parseWeather(this.text);
                if (isNaN(root.temperature)) {
                    retryTimer.restart();
                    return;
                }

                root.icon = Assets.weather.getIcon();
            }
        }
        onExited: exitCode => {
            if (exitCode !== 0)
                retryTimer.restart();
        }
    }

    Timer {
        id: retryTimer
        interval: 30 * 1000
        repeat: false
        onTriggered: fetchProcess.running = true
    }

    Timer {
        interval: 10 * 60 * 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: fetchProcess.running = true
    }
}
