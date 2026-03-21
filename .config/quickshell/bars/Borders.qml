pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects

import qs
import qs.services
import qs.components.notifications

PanelWindow {
    id: root
    focusable: true

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "transparent"

    mask: Region {
        x: 0
        y: topBar.height
        width: root.width
        height: root.height - topBar.height - bottomBar.height
        intersection: Intersection.Subtract

        Region {
            item: notifPopup.isVisible ? notifPopup : null
            intersection: Intersection.Subtract
        }

        Region {
            item: topBar.runnerPopupItem
            intersection: Intersection.Subtract
        }
        Region {
            item: topBar.dashboardPopupItem
            intersection: Intersection.Subtract
        }
        Region {
            item: bottomBar.batteryPopupItem
            intersection: Intersection.Subtract
        }
        Region {
            item: bottomBar.systemPopupItem
            intersection: Intersection.Subtract
        }
        Region {
            item: bottomBar.mediaPopupItem
            intersection: Intersection.Subtract
        }
        Region {
            item: bottomBar.utilsPopupItem
            intersection: Intersection.Subtract
        }
        Region {
            item: bottomBar.notificationsPopupItem
            intersection: Intersection.Subtract
        }
    }

    HyprlandFocusGrab {
        active: RunnerState.visible && screen.name === RunnerState.targetScreen
        windows: [root]
        onCleared: RunnerState.visible = false
    }

    NotificationPopup {
        id: notifPopup
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 100
        anchors.rightMargin: 40
    }

    Item {
        anchors.fill: parent
        layer.enabled: true

        TopBar {
            id: topBar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: 50
            z: 1
            showRunner: screen.name === RunnerState.targetScreen
        }

        BottomBar {
            id: bottomBar
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: 50
            z: 1
        }

        Rectangle {
            anchors.fill: parent
            color: Style.palette.base

            layer.enabled: true
            layer.effect: MultiEffect {
                maskSource: mask
                maskEnabled: true
                maskInverted: true
            }
        }

        Item {
            id: mask

            anchors.fill: parent
            layer.enabled: true
            visible: false

            Rectangle {
                anchors.fill: parent
                anchors.margins: 10
                anchors.topMargin: topBar.implicitHeight
                anchors.bottomMargin: bottomBar.implicitHeight
                radius: 20
            }
        }
    }
}
