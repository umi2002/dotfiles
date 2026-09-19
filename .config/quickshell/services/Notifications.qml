pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick

import qs

Singleton {
    id: root

    property bool doNotDisturb: false

    signal notificationReceived(var notification)

    property ListModel history: ListModel {}
    readonly property int storageWriteDebounce: Config.storageWriteDebounce

    NotificationServer {
        id: server
        keepOnReload: true
        bodySupported: true
        bodyHyperlinksSupported: true
        bodyMarkupSupported: true
        actionIconsSupported: true
        persistenceSupported: true
        imageSupported: true
        actionsSupported: true

        onNotification: notification => {
            notification.tracked = true;
            root.notificationReceived(notification);
            root.history.insert(0, {
                image: notification.image,
                appIcon: notification.appIcon,
                appName: notification.appName,
                summary: notification.summary,
                body: notification.body,
                time: Date.now()
            });

            while (root.history.count > Config.notificationHistoryLimit) {
                root.history.remove(root.history.count - 1);
            }

            storageWriteTimer.restart();
        }
    }

    function dismissAll() {
        history.clear();
        adapter.items = [];
        storage.writeAdapter();
    }

    Timer {
        id: storageWriteTimer
        interval: root.storageWriteDebounce
        onTriggered: {
            const items = [];
            for (let i = 0; i < root.history.count; i++)
                items.push(Object.assign({}, root.history.get(i)));
            adapter.items = items;
            storage.writeAdapter();
        }
    }

    FileView {
        id: storage
        path: Quickshell.statePath("notifs.json")
        onLoaded: {
            for (const item of adapter.items)
                root.history.append(item);
        }

        JsonAdapter {
            id: adapter
            property var items: []
        }
    }
}
