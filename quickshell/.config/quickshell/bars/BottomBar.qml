import Quickshell.Widgets
import QtQuick

import qs.components
import qs.components.battery
import qs.components.media
import qs.components.system
import qs.components.utils

Rectangle {
    id: root
    required property var backdrop
    readonly property bool hasPopup: system.isExpanded || utilsPopup.isExpanded || mediaPopup.isExpanded || batteryPopup.isExpanded
    readonly property int margins: 10

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    StyledPopup {
        id: batteryPopup
        hoverEnabled: true
        anchors.left: battery.left
        anchors.bottom: battery.top
        height: batteryPopup.implicitHeight
        isExpanded: containsMouse || battery.containsMouse
        popupContent: BatteryPopup {}
    }

    Battery {
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
        backdrop: root.backdrop
        anchors.left: battery.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
    }

    StyledPopup {
        id: mediaPopup
        hoverEnabled: true
        anchors.horizontalCenter: media.horizontalCenter
        anchors.bottom: media.top
        height: mediaPopup.implicitHeight
        isExpanded: containsMouse || media.containsMouse
        popupContent: MediaPopup {}
    }

    Media {
        id: media
        anchors.centerIn: parent
    }

    Tray {
        anchors.right: utils.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: root.margins
    }

    StyledPopup {
        id: utilsPopup
        hoverEnabled: true
        anchors.right: utils.right
        anchors.bottom: utils.top
        height: utilsPopup.implicitHeight
        isExpanded: containsMouse || utils.containsMouse
        popupContent: UtilsPopup {}
    }

    Utils {
        id: utils
        anchors.right: language.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: root.margins
    }

    Language {
        id: language
        anchors.right: parent.right
        anchors.rightMargin: root.margins
        anchors.verticalCenter: parent.verticalCenter
    }
}
