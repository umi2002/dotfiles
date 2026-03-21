pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    property bool doNotDisturb: false

    signal notificationReceived(var notification)

    property ListModel history: ListModel {}
    readonly property int storageWriteDebounce: 1000

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

            while (root.history.count > 100) {
                root.history.remove(root.history.count - 1);
            }

            storageWriteTimer.restart();
        }
    }

    function dismissAll() {
        history.clear();
        storage.setText([]);
    }

    Timer {
        id: storageWriteTimer
        interval: root.storageWriteDebounce
        onTriggered: {
            const items = [];
            for (let i = 0; i < root.history.count; i++)
                items.push(root.history.get(i));
            storage.setText(JSON.stringify(items));
        }
    }

    FileView {
        id: storage
        path: "/home/umi/.local/state/quickshell/notifs.json"
        onLoaded: {
            const text = storage.text();
            if (text) {
                const items = JSON.parse(text);
                for (const item of items)
                    root.history.append(item);
            }
        }
    }

    Process {
        command: ["mkdir", "-p", "/home/umi/.local/state/quickshell"]
        running: true
    }
}
