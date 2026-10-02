pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs
import qs.components

WrapperMouseArea {
    id: root

    required property url icon

    property bool revealed: true

    property color iconColor: Style.palette.text
    property int size: 20

    signal actionTriggered

    opacity: root.revealed ? 1 : 0
    enabled: root.revealed
    cursorShape: Qt.PointingHandCursor

    onClicked: root.actionTriggered()

    Behavior on opacity {
        NumberAnimation {
            duration: Style.animation.normal
        }
    }

    Rectangle {
        implicitWidth: root.size
        implicitHeight: root.size
        color: "transparent"

        ColorizedIcon {
            anchors.fill: parent
            iconSource: root.icon
            iconColor: root.iconColor
        }
    }
}
