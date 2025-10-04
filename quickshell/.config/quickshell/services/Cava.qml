pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool ready: false
    property list<int> bars: []

    Component.onCompleted: {
        Quickshell.execDetached(["sh", "-c", "rm -f /tmp/cava_fifo && mkfifo /tmp/cava_fifo"]);
        startTimer.start();
    }

    Timer {
        id: startTimer
        interval: 200
        repeat: false
        onTriggered: {
            cavaProcess.running = true;
            fifoTimer.start();
        }
    }

    Timer {
        id: fifoTimer
        interval: 500
        repeat: false
        onTriggered: {
            fifoProcess.running = true;
        }
    }

    Process {
        id: cavaProcess
        command: ["sh", "-c", "cava -p /dev/stdin << 'EOF'\n[general]\nbars=20\n[output]\nmethod=raw\nraw_target=/tmp/cava_fifo\ndata_format=ascii\nascii_max_range=100\nbar_delimiter=59\nEOF"]
        running: false
    }

    Process {
        id: fifoProcess
        command: ["cat", "/tmp/cava_fifo"]
        running: false
        stdout: SplitParser {
            splitMarker: "\n"

            onRead: data => {
                let values = data.trim().split(';');
                let newBars = [];
                for (let i = 0; i < 20; i++) {
                    newBars.push(parseInt(values[i] || 0));
                }
                root.bars = newBars;
                root.ready = true;
            }
        }

        onExited: (exitCode, exitStatus) => {
            fifoProcess.running = true;
        }
    }
}
