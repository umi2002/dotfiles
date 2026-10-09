pragma ComponentBehavior: Bound

import Quickshell.Wayland
import QtQuick

import qs

Rectangle {
    id: root

    property var screenSource: null
    property bool cropped: false
    property int cropX: 0
    property int cropY: 0
    property int cropW: 0
    property int cropH: 0
    property string placeholder: "No source selected"

    readonly property real sourceW: root.screenSource ? root.screenSource.width : 1
    readonly property real sourceH: root.screenSource ? root.screenSource.height : 1
    readonly property real visibleW: root.cropped && root.cropW > 0 ? root.cropW : root.sourceW
    readonly property real visibleH: root.cropped && root.cropH > 0 ? root.cropH : root.sourceH
    readonly property real factor: Math.min(root.width / root.visibleW, root.height / root.visibleH)
    readonly property real offsetX: root.cropped ? root.cropX - (root.screenSource ? root.screenSource.x : 0) : 0
    readonly property real offsetY: root.cropped ? root.cropY - (root.screenSource ? root.screenSource.y : 0) : 0

    radius: Style.radius.small
    color: Style.palette.crust
    clip: true

    ScreencopyView {
        visible: root.screenSource !== null
        live: true
        paintCursor: false
        captureSource: root.screenSource
        width: root.sourceW * root.factor
        height: root.sourceH * root.factor
        x: (root.width - root.visibleW * root.factor) / 2 - root.offsetX * root.factor
        y: (root.height - root.visibleH * root.factor) / 2 - root.offsetY * root.factor
    }

    Text {
        anchors.centerIn: parent
        visible: root.screenSource === null
        text: root.placeholder
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: Style.palette.overlay1
    }
}
