pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import Qt5Compat.GraphicalEffects

import qs
import qs.components

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
    color: "transparent"

    ColorizedIcon {
        iconSource: Qt.resolvedUrl(root.icon)
        anchors.fill: parent
        anchors.topMargin: root.iconMargin
        anchors.bottomMargin: root.iconMargin
        iconColor: root.isSelected ? Style.palette.green : Style.palette.text

        Behavior on iconColor {
            ColorAnimation {
                duration: 200
            }
        }
    }
}
