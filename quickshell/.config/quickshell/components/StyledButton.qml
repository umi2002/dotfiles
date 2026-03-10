pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs

WrapperMouseArea {
    id: root

    property string text: ""
    property bool busy: false
    property color backgroundColor: Style.palette.surface0
    property color hoverColor: Style.palette.overlay0
    property color textColor: Style.palette.text
    property int fontSize: Style.font.size2
    property string fontFamily: Style.font.family3
    property int borderWidth: 1
    property int buttonWidth: 100
    property int buttonHeight: 30

    property bool animateOnClick: true

    enabled: !busy
    cursorShape: busy ? Qt.BusyCursor : Qt.PointingHandCursor

    onClicked: {
        if (animateOnClick) {
            pulseAnimation.start();
        }
    }

    Rectangle {
        id: button
        implicitWidth: root.buttonWidth
        implicitHeight: root.buttonHeight
        border.width: root.borderWidth
        color: root.backgroundColor

        ColorAnimation on color {
            id: pulseAnimation
            from: root.backgroundColor
            to: root.hoverColor
            duration: 200
            running: false

            onStopped: {
                reverseAnimation.start();
            }
        }

        ColorAnimation {
            id: reverseAnimation
            target: button
            property: "color"
            to: root.backgroundColor
            duration: 200
            running: false
        }

        Text {
            text: root.text
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            anchors.fill: parent
            font.pointSize: root.fontSize
            font.family: root.fontFamily
            color: root.textColor
        }
    }
}
