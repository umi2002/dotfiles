import Quickshell.Services.UPower
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

Rectangle {
    id: root
    readonly property bool hasPopup: system.isHovered || utils.isHovered
    readonly property int margins: 10

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    Battery {
        id: battery
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        color: isCharging ? Style.palette.color2 : Style.palette.color3
    }

    System {
        id: system
        anchors.left: battery.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
    }

    Media {
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
