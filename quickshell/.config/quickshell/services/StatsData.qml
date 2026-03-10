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

    property real cpuUsage: 0
    property real memUsage: 0
    property real diskUsage: 0

    property real prevCpuTotal: 0
    property real prevCpuIdle: 0

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

    function parseResources(text) {
        for (const line of text.trim().split('\n')) {
            const parts = line.split(' ');
            if (parts[0] === 'cpu') {
                const total = parseFloat(parts[1]);
                const idle = parseFloat(parts[2]);
                const deltaTotal = total - root.prevCpuTotal;
                const deltaIdle = idle - root.prevCpuIdle;
                if (deltaTotal > 0)
                    root.cpuUsage = (deltaTotal - deltaIdle) / deltaTotal;
                root.prevCpuTotal = total;
                root.prevCpuIdle = idle;
            } else if (parts[0] === 'mem') {
                const used = parseFloat(parts[1]);
                const total = parseFloat(parts[2]);
                root.memUsage = total > 0 ? used / total : 0;
            } else if (parts[0] === 'disk') {
                const used = parseFloat(parts[1]);
                const total = parseFloat(parts[2]);
                root.diskUsage = total > 0 ? used / total : 0;
            }
        }
    }

    Process {
        id: fetchResources
        command: ["bash", "-c",
            "awk 'NR==1{printf \"cpu %d %d\\n\",$2+$3+$4+$5+$6+$7+$8+$9,$5+$6}' /proc/stat;" +
            "awk '/MemTotal/{t=$2}/MemAvailable/{a=$2}END{printf \"mem %d %d\\n\",t-a,t}' /proc/meminfo;" +
            "df / | awk 'NR==2{printf \"disk %d %d\\n\",$3,$2}'"
        ]
        stdout: StdioCollector {
            onStreamFinished: root.parseResources(this.text)
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: fetchResources.running = true
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
