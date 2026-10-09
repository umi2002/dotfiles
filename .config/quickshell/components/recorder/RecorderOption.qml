pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs

WrapperMouseArea {
    id: root

    required property string label
    required property bool selected

    signal picked

    cursorShape: Qt.PointingHandCursor

    onClicked: root.picked()

    Rectangle {
        implicitWidth: optionText.implicitWidth + Style.spacing.large
        implicitHeight: optionText.implicitHeight + Style.spacing.normal
        radius: height / 2
        color: root.selected ? Style.palette.surface1 : Style.palette.crust

        Behavior on color {
            ColorAnimation {
                duration: Style.animation.normal
            }
        }

        Text {
            id: optionText

            anchors.centerIn: parent
            text: root.label
            font.pointSize: Style.font.size2
            font.family: Style.font.family3
            color: root.selected ? Style.palette.green : Style.palette.subtext0

            Behavior on color {
                ColorAnimation {
                    duration: Style.animation.normal
                }
            }
        }
    }
}
