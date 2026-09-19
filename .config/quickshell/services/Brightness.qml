pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int brightness

    function setBrightness(brightness) {
        setBrightnessProcess.brightness = brightness;
        setBrightnessProcess.running = true;
    }

    Process {
        id: getBrightness
        command: ["brillo", "-G"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.brightness = parseInt(text) || 0;
            }
        }
    }

    Process {
        id: setBrightnessProcess
        property int brightness
        command: ["brillo", "-S", brightness.toString()]
    }

    property string backlightPath: ""

    Process {
        id: findBacklight
        command: ["sh", "-c", "ls -d /sys/class/backlight/*/brightness | head -1"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.backlightPath = text.trim();
            }
        }
    }

    FileView {
        path: root.backlightPath
        watchChanges: true
        onFileChanged: getBrightness.running = true
    }

    Component.onCompleted: {
        findBacklight.running = true;
        getBrightness.running = true;
    }
}
