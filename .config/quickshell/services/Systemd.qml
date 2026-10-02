pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQml

Singleton {
    id: root

    readonly property string failureResultId: "d9b373ed55a64feb8242e02dbe79a49c"
    readonly property string failedToStartId: "be02cf6855d2428ba40df7e9d022f03d"

    property string pendingUnit: ""
    property var userUnits: []
    property var systemUnits: []

    readonly property int failedCount: root.countFailed(userUnits) + root.countFailed(systemUnits)

    function isFailed(unit: var): bool {
        return unit?.active === "failed";
    }

    function countFailed(units: var): int {
        return units.filter(unit => root.isFailed(unit)).length;
    }

    function statusLabel(unit: var): string {
        if (root.isFailed(unit))
            return "Failed";
        switch (unit?.sub) {
        case "running":
            return "Running";
        case "exited":
            return "Exited";
        case "dead":
            return "Stopped";
        default:
            return unit?.sub ?? "";
        }
    }

    function refresh(): void {
        userQuery.running = true;
        systemQuery.running = true;
    }

    function control(unit: var, action: string): void {
        if (!unit?.unit || root.pendingUnit !== "")
            return;
        root.pendingUnit = unit.unit;
        controlProc.exec(["systemctl", unit.scope, action, unit.unit]);
    }

    function parseUnits(raw: string, scope: string): var {
        try {
            const parsed = JSON.parse(raw);
            if (!Array.isArray(parsed))
                return [];
            parsed.forEach(unit => unit.scope = scope);
            return parsed.sort((a, b) => {
                const aFailed = root.isFailed(a);
                const bFailed = root.isFailed(b);
                if (aFailed !== bFailed)
                    return aFailed ? -1 : 1;
                return a.unit.localeCompare(b.unit);
            });
        } catch (e) {
            return [];
        }
    }

    Process {
        id: userQuery

        command: ["systemctl", "--user", "list-units", "--type=service", "--output=json", "--no-pager"]
        stdout: StdioCollector {
            onStreamFinished: root.userUnits = root.parseUnits(text, "--user")
        }
    }

    Process {
        id: systemQuery

        command: ["systemctl", "--system", "list-units", "--type=service", "--output=json", "--no-pager"]
        stdout: StdioCollector {
            onStreamFinished: root.systemUnits = root.parseUnits(text, "--system")
        }
    }

    Process {
        id: controlProc

        onRunningChanged: {
            if (running || root.pendingUnit === "")
                return;
            root.pendingUnit = "";
            root.refresh();
        }
    }

    Process {
        id: failureWatcher

        running: true
        command: ["journalctl", "-f", "-n", "0", "-q", "-o", "cat", "--no-pager", "MESSAGE_ID=" + root.failureResultId, "+", "MESSAGE_ID=" + root.failedToStartId]
        stdout: SplitParser {
            onRead: debounce.restart()
        }
    }

    Timer {
        id: debounce

        interval: 1000
        onTriggered: root.refresh()
    }

    Component.onCompleted: root.refresh()
}
