pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.components
import qs.components.battery
import qs.components.media
import qs.components.system
import qs.components.utils
import qs.components.notifications

Rectangle {
    id: root
    readonly property alias batteryPopupItem: batteryPopup
    readonly property alias systemPopupItem: systemPopup
    readonly property alias mediaPopupItem: mediaPopup
    readonly property alias utilsPopupItem: utilsPopup
    readonly property alias notificationsPopupItem: notificationsPopup
    readonly property alias trayMenuPopupItem: trayMenuPopup
    readonly property alias trayWidgetItem: tray
    readonly property int margins: Style.spacing.normal

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    StyledPopup {
        id: batteryPopup
        anchors.left: battery.left
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
        anchors.left: system.left
        anchors.bottom: system.top
        isExpanded: system.isExpanded
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
        anchors.horizontalCenter: media.horizontalCenter
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
        x: Math.max(0, Math.min(tray.x + tray.menuCenter - width / 2, root.width - width))
        anchors.bottom: tray.top
        isExpanded: tray.menuItem !== null
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
        anchors.right: utils.right
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
        anchors.right: notifications.right
        anchors.bottom: notifications.top
        isExpanded: notifications.isExpanded
        popupContent: NotificationsHistoryPopup {}
    }

    NotificationsButton {
        id: notifications
        anchors.right: parent.right
        anchors.rightMargin: root.margins
        anchors.verticalCenter: parent.verticalCenter
    }
}
