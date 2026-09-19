pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs
import qs.services

WrapperMouseArea {
    id: root

    readonly property int timeout: 2000
    readonly property int animationDuration: 400

    property var currentNotification: null
    property int translation: implicitWidth + anchors.rightMargin

    readonly property bool isVisible: notificationPopup.opacity > 0

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onContainsMouseChanged: {
        if (containsMouse) {
            expireTimer.stop();
        } else {
            expireTimer.restart();
        }
    }

    onClicked: {
        hide();
        dismisstimer.restart();
    }

    function show() {
        notificationPopup.opacity = 1;
        root.translation = 0;
    }

    function hide() {
        notificationPopup.opacity = 0;
        root.translation = implicitWidth + anchors.rightMargin;
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

            if (root.containsMouse) {
                return;
            }

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
            root.currentNotification?.expire();
            root.currentNotification = null;
        }
    }

    Timer {
        id: dismisstimer
        interval: root.animationDuration
        onTriggered: {
            root.currentNotification?.dismiss();
            root.currentNotification = null;
        }
    }

    Rectangle {
        id: notificationPopup

        radius: Style.radius.small
        color: Style.palette.red
        opacity: 0
        implicitWidth: 400
        implicitHeight: card.implicitHeight
        clip: true

        transform: Translate {
            x: root.translation

            Behavior on x {
                NumberAnimation {
                    duration: root.animationDuration
                    easing.type: Easing.Bezier
                    easing.bezierCurve: Style.animation.curve
                }
            }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: root.animationDuration
                easing.type: Easing.Bezier
                easing.bezierCurve: Style.animation.curve
            }
        }

        NotificationCard {
            id: card
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: Style.spacing.normal
            anchors.rightMargin: Style.spacing.normal
            visible: root.currentNotification !== null
            notification: root.currentNotification
            Component.onCompleted: {
                height = implicitHeight;
                width = implicitWidth;
            }
        }
    }
}
