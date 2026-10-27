pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property var frequencies: adapter.frequencies

    readonly property var tabs: ["Apps", "Commands"]

    readonly property var commands: [
        {
            name: "Lock",
            comment: "Lock the session",
            icon: "system-lock-screen",
            exec: ["loginctl", "lock-session"]
        },
        {
            name: "Suspend",
            comment: "Suspend to RAM",
            icon: "system-suspend",
            exec: ["systemctl", "suspend"]
        },
        {
            name: "Log out",
            comment: "Close all apps and exit Hyprland",
            icon: "system-log-out",
            exec: ["hyprshutdown", "--no-fork"]
        },
        {
            name: "Reboot",
            comment: "Close all apps, exit Hyprland and restart",
            icon: "system-reboot",
            exec: ["hyprshutdown", "--no-fork", "--post-cmd", "systemctl reboot"]
        },
        {
            name: "Shut down",
            comment: "Close all apps, exit Hyprland and power off",
            icon: "system-shutdown",
            exec: ["hyprshutdown", "--no-fork", "--post-cmd", "systemctl poweroff"]
        }
    ]

    readonly property var apps: DesktopEntries.applications.values.filter(a => !a.noDisplay).sort((a, b) => (root.frequencies[b.id] ?? 0) - (root.frequencies[a.id] ?? 0) || a.name.localeCompare(b.name))

    function search(query, tab) {
        return tab === 1 ? root.searchCommands(query) : root.searchApps(query);
    }

    function searchCommands(query) {
        const q = query.trim().toLowerCase();
        if (!q) {
            return [...root.commands];
        }
        return root.commands.filter(c => c.name.toLowerCase().includes(q) || c.comment.toLowerCase().includes(q));
    }

    function searchApps(query) {
        const q = query.trim().toLowerCase();
        if (!q) {
            return [...root.apps];
        }

        const score = a => {
            const name = a.name.toLowerCase();
            if (name === q)
                return 0;
            if (name.startsWith(q))
                return 1;
            if (name.includes(q))
                return 2;
            if (a.genericName && a.genericName.toLowerCase().includes(q))
                return 3;
            if (a.comment && a.comment.toLowerCase().includes(q))
                return 4;
            return 5;
        };

        return root.apps.filter(a => score(a) < 5).sort((a, b) => score(a) - score(b));
    }

    function launch(appEntry) {
        if (appEntry.exec) {
            Quickshell.execDetached({
                command: ["systemd-run", "--user", "--collect", "--quiet", "--"].concat(appEntry.exec)
            });
            return;
        }
        adapter.frequencies = Object.assign({}, adapter.frequencies, {
            [appEntry.id]: (adapter.frequencies[appEntry.id] ?? 0) + 1
        });
        storage.writeAdapter();
        Quickshell.execDetached({
            command: ["uwsm", "app", "--"].concat(appEntry.command),
            workingDirectory: appEntry.workingDirectory
        });
    }

    Component.onCompleted: storage.waitForJob()

    FileView {
        id: storage
        path: Quickshell.statePath("runner-frequencies.json")
        preload: true
        blockLoading: true
        printErrors: false

        JsonAdapter {
            id: adapter
            property var frequencies: ({})
        }
    }
}
