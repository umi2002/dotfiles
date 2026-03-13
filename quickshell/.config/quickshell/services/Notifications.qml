pragma Singleton

import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property bool doNotDisturb: false

    signal notificationReceived(var notification)

    readonly property var notificationModel: server.trackedNotifications
    readonly property list<Notification> notifications: server.trackedNotifications.values
    readonly property int count: notifications.length
    readonly property bool hasUnread: count > 0

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
        }
    }

    function dismiss(notification) {
        notification.dismiss();
    }

    function dismissAll() {
        for (let i = notifications.length - 1; i >= 0; i--) {
            notifications[i].dismiss();
        }
    }
}
