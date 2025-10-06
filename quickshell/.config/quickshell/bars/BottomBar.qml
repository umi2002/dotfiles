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
    readonly property bool hasPopup: system.isExpanded || utilsPopup.isExpanded || mediaPopup.isExpanded
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

    WrapperMouseArea {
        id: mediaPopupMouseArea
        hoverEnabled: true
        anchors.horizontalCenter: media.horizontalCenter
        anchors.bottom: media.top
        height: mediaPopup.implicitHeight + 20

        StyledPopup {
            id: mediaPopup
            isExpanded: mediaPopupMouseArea.containsMouse || media.containsMouse
            popupContent: MediaPopup {}
        }
    }

    Media {
        id: media
        anchors.centerIn: parent
    }

    WrapperMouseArea {
        id: utilsPopupMouseArea
        hoverEnabled: true
        anchors.right: utils.right
        anchors.bottom: utils.top
        height: utilsPopup.implicitHeight + 20

        StyledPopup {
            id: utilsPopup
            isExpanded: utilsPopupMouseArea.containsMouse || utils.containsMouse
            popupContent: UtilsPopup {}
        }
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
