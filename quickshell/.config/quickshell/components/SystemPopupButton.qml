pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs

WrapperMouseArea {
    id: root
    required property string icon
    required property bool isSelected
    cursorShape: Qt.PointingHandCursor

    Rectangle {
        implicitWidth: 100
        implicitHeight: 50
        radius: 10
        color: root.isSelected ? Style.palette.border1 : Style.palette.background2

        Behavior on color {
            ColorAnimation {
                duration: 200
            }
        }

        IconImage {
            source: Qt.resolvedUrl(root.icon)
            anchors.fill: parent
            anchors.topMargin: 5
            anchors.bottomMargin: 5
        }
    }
}
