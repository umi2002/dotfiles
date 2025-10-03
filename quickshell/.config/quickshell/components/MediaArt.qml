import Quickshell.Widgets
import QtQuick

import qs.services

Rectangle {
    id: root

    ClippingRectangle {
        anchors.fill: parent
        anchors.margins: 5
        radius: Infinity
        clip: true
        color: "transparent"

        Image {
            anchors.fill: parent
            source: Media.art
            sourceSize.width: root.width * 2
            sourceSize.height: root.height * 2
            smooth: true
            antialiasing: true
            fillMode: Image.PreserveAspectCrop
        }
    }
}
