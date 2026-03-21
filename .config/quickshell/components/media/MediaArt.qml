import QtQuick
import Qt5Compat.GraphicalEffects

import qs.services

MediaSection {
    id: root

    Image {
        id: artImage
        anchors.fill: parent
        anchors.margins: 5
        source: Media.art
        visible: false
    }

    Rectangle {
        id: artMask
        anchors.fill: artImage
        radius: parent.radius
        visible: false
    }

    OpacityMask {
        anchors.fill: artImage
        source: artImage
        maskSource: artMask
    }
}
