import QtQuick

import qs
import qs.services

Rectangle {
    id: root

    readonly property int timeout: 2000
    readonly property int animationDuration: 200

    property var currentNotification: null
    property int translation: implicitWidth + anchors.rightMargin

    radius: 10
    color: Style.palette.red
    opacity: 0
    implicitWidth: 400
    implicitHeight: card.implicitHeight
    clip: true

    function show() {
        root.opacity = 1;
        root.translation = 0;
    }

    function hide() {
        root.opacity = 0;
        root.translation = implicitWidth + anchors.rightMargin;
    }

    transform: Translate {
        x: root.translation

        Behavior on x {
            NumberAnimation {
                duration: root.animationDuration
            }
        }
    }

    Behavior on opacity {
        NumberAnimation {
            duration: root.animationDuration
        }
    }

    Connections {
        target: Notifications
        function onNotificationReceived(notif) {
            root.currentNotification?.expire();

            if (Notifications.doNotDisturb) {
                return;
            }

            root.show();
            root.currentNotification = notif;
            expireTimer.restart();
        }
    }

    Connections {
        target: root.currentNotification
        function onClosed() {
            animationTimer.stop();
            root.currentNotification = null;
        }
    }

    Timer {
        id: expireTimer
        interval: root.timeout
        onTriggered: {
            root.hide();
            animationTimer.restart();
        }
    }

    Timer {
        id: animationTimer
        interval: root.animationDuration
        onTriggered: {
            root.currentNotification.expire();
            root.currentNotification = null;
        }
    }

    NotificationCard {
        id: card
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 10
        visible: root.currentNotification !== null
        notification: root.currentNotification
    }
}
