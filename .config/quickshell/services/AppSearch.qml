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

        return appDb.apps.filter(a => a.name.toLowerCase().includes(q) || (a.genericName && a.genericName.toLowerCase().includes(q)) || (a.comment && a.comment.toLowerCase().includes(q)));
    }

    function launch(appEntry) {
        appDb.incrementFrequency(appEntry.id);
        Quickshell.execDetached({
            command: appEntry.entry.command,
            workingDirectory: appEntry.entry.workingDirectory
        });
    }
}
