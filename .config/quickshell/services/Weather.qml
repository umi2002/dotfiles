pragma Singleton

import Quickshell
import Quickshell.Io
import QtQml

import qs
import qs.assets

Singleton {
    id: root

    property string location: ""
    property real temperature: NaN
    property real humidity: NaN
    property string lastUpdated: ""
    property int weatherCode: -1
    property bool isDay: false
    property url icon: Assets.weather.clearDay

    function parseWeather(json) {
        if (json.error)
            return;

        const current = json.current;
        root.temperature = current.temp_c;
        root.humidity = current.humidity;
        root.location = json.location.name;
        root.lastUpdated = json.location.localtime;
        root.weatherCode = current.condition.code;
        root.isDay = current.is_day === 1;
        root.icon = Assets.weather.getIcon(root.weatherCode, root.isDay);
    }

    Process {
        id: fetchProcess
        command: ["curl", "-s", `https://api.weatherapi.com/v1/current.json?key=${Secrets.weather}&q=${Secrets.location}&aqi=no`]
        stdout: StdioCollector {
            onStreamFinished: {
                root.parseWeather(JSON.parse(this.text));
                if (isNaN(root.temperature))
                    retryTimer.restart();
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
