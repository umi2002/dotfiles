pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property string outputDir: Quickshell.env("HOME") + "/Videos"

    property bool recording: false
    property bool starting: false
    property bool selecting: false
    property int elapsed: 0
    property bool audioSystem: true
    property bool audioMic: false
    property string sourceKind: "monitor"
    property bool sourceSelected: false
    property string targetMonitor: ""
    property int regionX: 0
    property int regionY: 0
    property int regionW: 0
    property int regionH: 0
    property string pendingFile: ""
    property string lastFile: ""
    property string errorMessage: ""
    property bool cancelRequested: false

    readonly property bool active: root.recording || root.starting || root.selecting

    readonly property var previewScreen: {
        if (!root.sourceSelected)
            return null;
        if (root.sourceKind === "monitor")
            return Quickshell.screens.find(screen => screen.name === root.targetMonitor) ?? null;
        return Quickshell.screens.find(screen => root.regionX >= screen.x && root.regionY >= screen.y && root.regionX < screen.x + screen.width && root.regionY < screen.y + screen.height) ?? (Quickshell.screens[0] ?? null);
    }

    readonly property string sourceLabel: {
        if (!root.sourceSelected)
            return "No source selected";
        if (root.sourceKind === "monitor")
            return root.targetMonitor;
        return root.regionW + "x" + root.regionH + " at " + root.regionX + "," + root.regionY;
    }

    readonly property string elapsedLabel: {
        const mins = Math.floor(root.elapsed / 60);
        const secs = root.elapsed % 60;
        return mins + ":" + (secs < 10 ? "0" : "") + secs;
    }

    readonly property string lastFileName: root.lastFile === "" ? "" : root.lastFile.split("/").pop()

    function audioArgs() {
        const sources = [];
        if (root.audioSystem)
            sources.push("default_output");
        if (root.audioMic)
            sources.push("default_input");
        return sources.length === 0 ? [] : ["-a", sources.join("|")];
    }

    function captureArgs() {
        if (root.sourceKind === "region")
            return ["-w", "region", "-region", root.regionW + "x" + root.regionH + "+" + root.regionX + "+" + root.regionY];
        return ["-w", root.targetMonitor];
    }

    function setKind(kind) {
        if (root.active || kind === root.sourceKind)
            return;
        root.sourceKind = kind;
        root.sourceSelected = false;
        root.errorMessage = "";
    }

    function selectRegion() {
        if (root.active)
            return;
        root.errorMessage = "";
        root.cancelRequested = false;
        root.selecting = true;
        regionPicker.running = true;
    }

    function pickMonitor(name) {
        if (root.active)
            return;
        root.errorMessage = "";
        root.sourceKind = "monitor";
        root.targetMonitor = name;
        root.sourceSelected = true;
    }

    function start() {
        if (root.active || !root.sourceSelected)
            return;
        root.errorMessage = "";
        root.lastFile = "";
        root.elapsed = 0;
        root.cancelRequested = false;
        root.pendingFile = root.outputDir + "/recording-" + Qt.formatDateTime(new Date(), "yyyy-MM-dd-hhmmss") + ".mp4";
        root.starting = true;
        recorder.command = ["gpu-screen-recorder"].concat(root.captureArgs(), ["-k", "h264"], root.audioArgs(), ["-o", root.pendingFile]);
        recorder.running = true;
    }

    function cancel() {
        if (root.selecting) {
            root.cancelRequested = true;
            regionPicker.signal(15);
            return;
        }
        if (!root.starting)
            return;
        root.cancelRequested = true;
        if (recorder.running)
            recorder.signal(2);
        else
            root.starting = false;
    }

    function stop() {
        if (root.recording)
            recorder.signal(2);
    }

    function toggle() {
        if (root.recording)
            root.stop();
        else if (root.starting || root.selecting)
            root.cancel();
        else
            root.start();
    }

    IpcHandler {
        target: "recorder"

        function start(): void {
            root.start();
        }

        function stop(): void {
            root.stop();
        }

        function cancel(): void {
            root.cancel();
        }

        function selectRegion(): void {
            root.selectRegion();
        }
    }

    Timer {
        id: elapsedTimer

        interval: 1000
        repeat: true
        onTriggered: root.elapsed += 1
    }

    Timer {
        id: startProbe

        interval: 250
        repeat: true
        running: root.starting && recorder.running
        onTriggered: {
            if (!outputProbe.running)
                outputProbe.running = true;
        }
    }

    Process {
        id: outputProbe

        command: ["test", "-s", root.pendingFile]
        onExited: code => {
            if (code !== 0 || !root.starting)
                return;
            root.starting = false;
            root.recording = true;
            root.elapsed = 0;
            elapsedTimer.restart();
        }
    }

    Process {
        id: savedProbe

        command: ["test", "-s", root.pendingFile]
        onExited: code => {
            if (code === 0)
                root.lastFile = root.pendingFile;
        }
    }

    Process {
        id: discard

        command: ["rm", "-f", root.pendingFile]
    }

    Process {
        id: regionPicker

        command: ["sh", "-c", "exec slurp < /dev/null"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.selecting = false;
                if (root.cancelRequested) {
                    root.cancelRequested = false;
                    return;
                }
                const parts = /^(-?\d+),(-?\d+) (\d+)x(\d+)$/.exec(text.trim());
                if (!parts)
                    return;
                root.regionX = parseInt(parts[1]);
                root.regionY = parseInt(parts[2]);
                root.regionW = parseInt(parts[3]);
                root.regionH = parseInt(parts[4]);
                root.sourceSelected = true;
                RecorderState.visible = true;
            }
        }

        onExited: root.selecting = false
    }

    Process {
        id: recorder

        stderr: StdioCollector {
            id: recorderError
        }

        onExited: {
            const wasStarting = root.starting;
            root.recording = false;
            root.starting = false;
            elapsedTimer.stop();

            if (root.cancelRequested) {
                root.cancelRequested = false;
                discard.running = true;
                return;
            }
            if (!wasStarting) {
                savedProbe.running = true;
                return;
            }
            const lines = recorderError.text.trim().split("\n").filter(line => line.length > 0);
            root.errorMessage = lines.length > 0 ? lines[lines.length - 1] : "Could not start recording.";
        }
    }
}
