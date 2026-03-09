pragma Singleton

import Quickshell
import Quickshell.Io
import QtQml

import qs.assets

Singleton {
    id: root

    readonly property string station: "Montreal-Trudeau"
    property real temperature
    property real humidity
    property string lastUpdated: ""
    property int weatherCode: -1
    property int cloudCover: -1
    property bool isDay: false
    readonly property url icon: Assets.weather.getIcon(weatherCode, isDay, cloudCover)

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

        const codeMatch = xml.match(/name="present_weather"[^>]*value="(\d+)"/);
        root.weatherCode = codeMatch ? parseInt(codeMatch[1]) : -1;

        const cloudMatch = xml.match(/name="tot_cloud_cover"[^>]*value="(\d+)"/);
        root.cloudCover = cloudMatch ? parseInt(cloudMatch[1]) : -1;

        const h = new Date().getHours();
        root.isDay = h >= 6 && h < 20;
    }

    Process {
        id: fetchProcess
        command: ["curl", "-s", "https://dd.weather.gc.ca/today/observations/swob-ml/latest/CYUL-MAN-swob.xml"]
        stdout: StdioCollector {
            onStreamFinished: root.parseWeather(this.text)
        }
    }

    Timer {
        interval: 10 * 60 * 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: fetchProcess.running = true
    }
}
