pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs

Rectangle {
    id: root
    required property string icon
    required property bool isSelected

    property int buttonWidth: 100
    property int buttonHeight: 50
    property int buttonRadius: 10
    property int iconMargin: 5

    implicitWidth: buttonWidth
    implicitHeight: buttonHeight
    radius: buttonRadius
    color: root.isSelected ? Style.palette.border1 : Style.palette.background2

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }

    IconImage {
        source: Qt.resolvedUrl(root.icon)
        anchors.fill: parent
        anchors.topMargin: root.iconMargin
        anchors.bottomMargin: root.iconMargin
    }
}
