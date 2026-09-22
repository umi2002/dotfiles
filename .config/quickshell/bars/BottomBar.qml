pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

import qs
import qs.components
import qs.components.battery
import qs.components.media
import qs.components.system
import qs.components.utils
import qs.components.notifications
import qs.services

Rectangle {
    id: root
    readonly property alias trayWidgetItem: tray
    readonly property int margins: Style.spacing.normal

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    StyledPopup {
        id: batteryPopup
        target: battery
        gravity: Edges.Left
        anchors.bottom: battery.top
        isExpanded: containsMouse || battery.containsMouse
        popupContent: BatteryPopup {}
    }

    BatteryWidget {
        id: battery
        anchors.left: parent.left
        anchors.leftMargin: root.margins
        anchors.verticalCenter: parent.verticalCenter
        z: 1
    }

    StyledPopup {
        id: systemPopup
        target: system
        gravity: Edges.Left
        anchors.bottom: system.top
        isExpanded: system.isExpanded && !HyprlandData.hasFullscreen
        dismissable: true
        onDismissed: system.isExpanded = false
        popupContent: SystemPopup {}
    }

    System {
        id: system
        anchors.left: battery.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
    }

    Language {
        id: language
        anchors.left: system.right
        anchors.leftMargin: root.margins
        anchors.verticalCenter: parent.verticalCenter
    }

    StyledPopup {
        id: mediaPopup
        target: media
        anchors.bottom: media.top
        isExpanded: containsMouse || media.containsMouse
        popupContent: MediaPopup {}
    }

    MediaWidget {
        id: media
        anchors.centerIn: parent
    }

    StyledPopup {
        id: trayMenuPopup
        target: tray
        targetOffset: tray.menuCenter
        anchors.bottom: tray.top
        isExpanded: tray.menuItem !== null
        dismissable: true
        onDismissed: tray.closeMenu()
        popupContent: TrayMenu {
            menuHandle: tray.menuItem?.menu ?? null
            onEntryTriggered: tray.closeMenu()
        }
    }

    TrayWidget {
        id: tray
        anchors.right: utils.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: root.margins
    }

    StyledPopup {
        id: utilsPopup
        target: utils
        gravity: Edges.Right
        anchors.bottom: utils.top
        isExpanded: containsMouse || utils.containsMouse
        popupContent: UtilsPopup {}
    }

    Utils {
        id: utils
        anchors.right: notifications.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: root.margins
    }

    StyledPopup {
        id: notificationsPopup
        target: notifications
        gravity: Edges.Right
        anchors.bottom: notifications.top
        isExpanded: notifications.isExpanded && !HyprlandData.hasFullscreen
        dismissable: true
        onDismissed: notifications.isExpanded = false
        popupContent: NotificationsHistoryPopup {}
    }

    NotificationsButton {
        id: notifications
        anchors.right: parent.right
        anchors.rightMargin: root.margins
        anchors.verticalCenter: parent.verticalCenter
    }
}
