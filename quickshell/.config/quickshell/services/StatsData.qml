pragma Singleton

import Quickshell
import Quickshell.Io
import QtQml

Singleton {
    id: root

    property string os: ""
    property string kernel: ""
    property string uptime: ""
    property string wm: ""
    property string cpu: ""
    property string gpu: ""

    function formatUptime(ms) {
        const totalSeconds = Math.floor(ms / 1000);
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
        let data = JSON.parse(text);

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
            case "Uptime":
                root.uptime = formatUptime(r.uptime);
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

    Process {
        id: fetchStats
        command: ["fastfetch", "--json"]
        stdout: StdioCollector {
            onStreamFinished: root.parseStats(this.text)
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: fetchStats.running = true
    }
}
