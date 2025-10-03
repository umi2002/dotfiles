import QtQuick
import QtQuick.Controls

import qs.services
import "../Style.js" as Style

Rectangle {
    id: root
    implicitWidth: 50

    Slider {
        id: slider
        property bool isUserInteracting: false

        anchors.centerIn: parent
        orientation: Qt.Vertical
        value: isUserInteracting ? value : Media.spotifyPlayer?.volume || 0
        from: 0
        to: 1

        onPressedChanged: {
            slider.isUserInteracting = pressed;
        }

        onMoved: {
            Media.setVolume(value);
        }

        HoverHandler {
            cursorShape: Qt.PointingHandCursor
        }

        background: Rectangle {
            implicitWidth: 10
            implicitHeight: root.implicitHeight - 50
            radius: implicitWidth / 2
            color: Style.palette.border1

            Rectangle {
                implicitWidth: parent.implicitWidth
                implicitHeight: (1 - slider.visualPosition) * parent.implicitHeight
                y: parent.height - height
                radius: implicitHeight / 2
                color: Style.palette.color1
            }
        }

        handle: Item {}
    }
}
