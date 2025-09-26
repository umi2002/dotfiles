pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int brightness
    property int maxBrightness
    readonly property int brightnessPercent: Math.round(brightness / maxBrightness * 100) || 0
    readonly property string brightnessIcon: {
        if (brightnessPercent > 80) {
            return "../assets/brightness_high_icon.svg";
        } else if (brightnessPercent > 40) {
            return "../assets/brightness_medium_icon.svg";
        } else {
            return "../assets/brightness_low_icon.svg";
        }
    }

    Process {
        id: getBrightness
        command: ["brightnessctl", "g"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.brightness = parseInt(text) || 0;
            }
        }
    }

    Process {
        id: getMaxBrightness
        command: ["brightnessctl", "m"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.maxBrightness = parseInt(text) || 0;
            }
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            getBrightness.running = true;
        }
    }

    Component.onCompleted: {
        getMaxBrightness.running = true;
    }
}
