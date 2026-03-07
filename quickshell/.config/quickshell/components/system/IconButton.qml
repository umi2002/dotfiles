pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import Qt5Compat.GraphicalEffects

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
    color: "transparent"

    Rectangle {
        id: bgMask
        anchors.fill: parent
        radius: parent.radius
        visible: false
    }

    LinearGradient {
        anchors.fill: parent
        source: bgMask
        start: Qt.point(0, 0)
        end: Qt.point(width, height)
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: root.isSelected ? Style.palette.border1 : Style.palette.background3

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
            GradientStop {
                position: 1.0
                color: root.isSelected ? Style.palette.color1 : Style.palette.background4

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
            }
        }
    }

    IconImage {
        source: Qt.resolvedUrl(root.icon)
        anchors.fill: parent
        anchors.topMargin: root.iconMargin
        anchors.bottomMargin: root.iconMargin
    }
}
