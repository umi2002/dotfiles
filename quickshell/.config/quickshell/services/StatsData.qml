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
        id: procStat
        path: "/proc/stat"
        onLoaded: {
            const parts = text().split('\n')[0].trim().split(/\s+/);
            const user = parseFloat(parts[1]);
            const nice = parseFloat(parts[2]);
            const system = parseFloat(parts[3]);
            const idle = parseFloat(parts[4]);
            const iowait = parseFloat(parts[5]);
            const irq = parseFloat(parts[6]);
            const softirq = parseFloat(parts[7]);
            const steal = parseFloat(parts[8]);

            const total = user + nice + system + idle + iowait + irq + softirq + steal;
            const idleTotal = idle + iowait;
            const deltaTotal = total - root.prevCpuTotal;
            const deltaIdle = idleTotal - root.prevCpuIdle;
            if (deltaTotal > 0)
                root.cpuUsage = (deltaTotal - deltaIdle) / deltaTotal;
            root.prevCpuTotal = total;
            root.prevCpuIdle = idleTotal;
        }
    }

    FileView {
        id: procMem
        path: "/proc/meminfo"
        onLoaded: {
            let memTotal = 0;
            let memAvailable = 0;
            for (const line of text().split('\n')) {
                if (line.startsWith('MemTotal:'))
                    memTotal = parseFloat(line.split(/\s+/)[1]);
                else if (line.startsWith('MemAvailable:'))
                    memAvailable = parseFloat(line.split(/\s+/)[1]);
                if (memTotal > 0 && memAvailable > 0)
                    break;
            }
            if (memTotal > 0)
                root.memUsage = (memTotal - memAvailable) / memTotal;
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
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            procStat.reload();
            procMem.reload();
            procUptime.reload();
        }
    }

    Process {
        id: fetchDisk
        command: ["df", "/"]
        stdout: StdioCollector {
            onStreamFinished: {
                const lines = this.text.trim().split('\n');
                if (lines.length >= 2) {
                    const parts = lines[1].trim().split(/\s+/);
                    const used = parseFloat(parts[2]);
                    const total = parseFloat(parts[1]);
                    root.diskUsage = total > 0 ? used / total : 0;
                }
            }
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: fetchDisk.running = true
    }

    Process {
        id: fetchStats
        command: ["fastfetch", "--json"]
        stdout: StdioCollector {
            onStreamFinished: root.parseStats(this.text)
        }
    }

    Component.onCompleted: fetchStats.running = true
}
