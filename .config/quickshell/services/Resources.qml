pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQml

import qs

Singleton {
    id: root

    property real cpuUsage: 0
    property real memUsage: 0
    property real diskUsage: 0

    property real prevCpuTotal: 0
    property real prevCpuIdle: 0

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

    Timer {
        interval: Config.statsInterval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            procStat.reload();
            procMem.reload();
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
        interval: Config.diskInterval
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: fetchDisk.running = true
    }
}
