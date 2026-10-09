pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs

WrapperMouseArea {
    id: root

    required property var screenSource
    required property bool selected

    signal picked

    cursorShape: Qt.PointingHandCursor

    onClicked: root.picked()

    Rectangle {
        implicitWidth: 150
        implicitHeight: 112
        radius: Style.radius.small
        color: root.selected ? Style.palette.surface1 : Style.palette.crust
        border.width: root.selected ? 2 : 1
        border.color: root.selected ? Style.palette.green : Style.palette.surface0

        Behavior on color {
            ColorAnimation {
                duration: Style.animation.normal
            }
        }

        RecorderPreview {
            id: thumb

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: Style.spacing.small
            height: 72
            screenSource: root.screenSource
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: thumb.bottom
            anchors.topMargin: Style.spacing.small
            width: parent.width - Style.spacing.normal
            horizontalAlignment: Text.AlignHCenter
            text: root.screenSource ? root.screenSource.name : ""
            elide: Text.ElideMiddle
            font.pointSize: Style.font.size2
            font.family: Style.font.family3
            color: root.selected ? Style.palette.green : Style.palette.subtext0
        }
    }
}
