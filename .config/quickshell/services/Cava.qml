pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

import qs

Singleton {
    id: root

    readonly property int bars: Config.cavaBars
    readonly property bool active: refCount > 0
    property int refCount: 0
    property bool configReady: false
    property var values: new Array(bars).fill(0)

    readonly property string configText: `[general]
framerate = 30
bars = ${bars}

[input]
method = pipewire
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 100
`

    function acquire() {
        refCount++;
    }

    function release() {
        refCount = Math.max(0, refCount - 1);
    }

    Component.onCompleted: configFile.setText(configText)

    FileView {
        id: configFile
        path: Quickshell.statePath("cava.conf")
        printErrors: false

        onSaved: root.configReady = true
    }

    Process {
        id: cavaProcess
        running: root.active && root.configReady
        command: ["cava", "-p", configFile.path]

        stdout: SplitParser {
            onRead: line => {
                const parts = line.split(";").filter(part => part.length > 0);
                if (parts.length === 0)
                    return;
                root.values = parts.map(part => Math.min(1, (parseFloat(part) || 0) / 100));
            }
        }

        onExited: root.values = new Array(root.bars).fill(0)
    }
}
