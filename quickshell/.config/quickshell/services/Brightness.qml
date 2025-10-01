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

    function setBrightness(brightness) {
        setBrightnessProcess.brightness = brightness;
        setBrightnessProcess.running = true;
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
        id: setBrightnessProcess
        property int brightness
        command: ["brightnessctl", "set", brightness.toString() + "%"]
    }

    Process {
        id: getMaxBrightness
        command: ["brightnessctl", "m"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.maxBrightness = parseInt(text) || 0;
                getBrightness.running = true;
            }
        }
    }

    Process {
        id: brightnessMonitor
        command: ["inotifywait", "-m", "-e", "modify", "/sys/class/backlight/amdgpu_bl1/brightness"]
        stdout: SplitParser {
            onRead: () => {
                getBrightness.running = true;
            }
        }
    }

    Component.onCompleted: {
        getMaxBrightness.running = true;
        brightnessMonitor.running = true;
    }
}
