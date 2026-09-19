pragma ComponentBehavior: Bound

import QtQuick
import Qt5Compat.GraphicalEffects

import qs
import qs.services

MediaSection {
    id: root

    Image {
        id: artImage
        anchors.fill: parent
        anchors.margins: Style.spacing.small
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
