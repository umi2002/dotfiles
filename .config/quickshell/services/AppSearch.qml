pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    readonly property var frequencies: adapter.frequencies

    readonly property var apps: DesktopEntries.applications.values.filter(a => !a.noDisplay).sort((a, b) => (root.frequencies[b.id] ?? 0) - (root.frequencies[a.id] ?? 0) || a.name.localeCompare(b.name))

    function search(query) {
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
