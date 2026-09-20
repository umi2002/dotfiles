pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQml

import qs

Singleton {
    id: root

    property string os: ""
    property string kernel: ""
    property string uptime: ""
    property string wm: ""
    property string cpu: ""
    property string gpu: ""

    function formatUptime(totalSeconds) {
        totalSeconds = Math.floor(totalSeconds);
        const days = Math.floor(totalSeconds / 86400);
        const hours = Math.floor((totalSeconds % 86400) / 3600);
        const mins = Math.floor((totalSeconds % 3600) / 60);

        const parts = [];
        if (days > 0)
            parts.push(`${days}d`);
        if (hours > 0)
            parts.push(`${hours}h`);
        if (mins > 0 || parts.length === 0)
            parts.push(`${mins}m`);
        return parts.join(' ');
    }

    function parseStats(text) {
        let data;
        try {
            data = JSON.parse(text);
        } catch (e) {
            console.warn("SystemInfo: could not parse fastfetch output:", e);
            return;
        }

        for (const item of data) {
            const r = item.result;
            if (!r) {
                continue;
            }

            switch (item.type) {
            case "OS":
                root.os = r.prettyName || r.name || "";
                break;
            case "Kernel":
                root.kernel = (r.name && r.release) ? `${r.name} ${r.release}` : (r.release || "");
                break;
            case "WM":
                root.wm = r.version ? `${r.prettyName} ${r.version}` : (r.prettyName || "");
                break;
            case "CPU":
                root.cpu = r.cpu || "";
                break;
            case "GPU":
                root.gpu = (Array.isArray(r) && r.length > 0) ? (r[0].name || "") : (r.name || "");
                break;
            }
        }
    }

    FileView {
        id: procUptime
        path: "/proc/uptime"
        onLoaded: {
            const seconds = parseFloat(text().split(' ')[0]);
            root.uptime = root.formatUptime(seconds);
        }
    }

    Timer {
        interval: Config.statsInterval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: procUptime.reload()
    }

    Process {
        id: fetchStats
        command: ["fastfetch", "--json", "-s", "OS:Kernel:WM:CPU:GPU"]
        stdout: StdioCollector {
            onStreamFinished: root.parseStats(this.text)
        }
    }

    Component.onCompleted: fetchStats.running = true
}
