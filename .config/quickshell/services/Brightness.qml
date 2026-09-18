pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import qs.assets

Singleton {
    id: root

    property int brightness
    readonly property string brightnessIcon: {
        if (brightness > 80) {
            return Assets.brightness.high;
        } else if (brightness > 40) {
            return Assets.brightness.medium;
        } else {
            return Assets.brightness.low;
        }
    }

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

    FileView {
        path: "/sys/class/backlight/amdgpu_bl1/brightness"
        watchChanges: true
        onFileChanged: getBrightness.running = true
    }

    Component.onCompleted: {
        getBrightness.running = true;
    }
}
