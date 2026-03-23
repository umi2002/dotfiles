pragma Singleton

import Quickshell
import Caelestia

Singleton {
    id: root

    AppDb {
        id: appDb
        path: Quickshell.shellDir + "/runner-apps.sqlite"
        favouriteApps: []
        entries: DesktopEntries.applications.values.filter(a => !a.noDisplay)
    }

    function search(query) {
        const q = query.trim().toLowerCase();
        if (!q) {
            return appDb.apps;
        }

        const score = (a) => {
            const name = a.name.toLowerCase();
            if (name === q) return 0;
            if (name.startsWith(q)) return 1;
            if (name.includes(q)) return 2;
            if (a.genericName && a.genericName.toLowerCase().includes(q)) return 3;
            if (a.comment && a.comment.toLowerCase().includes(q)) return 4;
            return 5;
        };

        return appDb.apps
            .filter(a => score(a) < 5)
            .sort((a, b) => score(a) - score(b));
    }

    function launch(appEntry) {
        appDb.incrementFrequency(appEntry.id);
        Quickshell.execDetached({
            command: appEntry.entry.command,
            workingDirectory: appEntry.entry.workingDirectory
        });
    }
}
