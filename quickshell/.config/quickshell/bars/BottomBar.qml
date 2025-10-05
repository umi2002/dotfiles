import QtQuick

import qs.components
import qs.components.battery
import qs.components.system

Rectangle {
    id: root
    required property var backdrop
    readonly property bool hasPopup: system.isExpanded || utils.isHovered || media.isHovered
    readonly property int margins: 10

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    Battery {
        id: battery
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        z: 1
    }

    StyledPopup {
        id: systemPopup
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: system.top
        anchors.bottomMargin: 20
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

    Media {
        id: media
        anchors.centerIn: parent
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
        anchors.verticalCenter: parent.verticalCenter
    }
}
