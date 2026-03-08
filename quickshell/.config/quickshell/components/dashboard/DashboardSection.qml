pragma ComponentBehavior: Bound

import QtQuick
import Qt5Compat.GraphicalEffects

import qs
import qs.assets

Rectangle {
    radius: 10

    color: Qt.rgba(Style.palette.background1.r, Style.palette.background1.g, Style.palette.background1.b, 0.6)
    border.width: 1
    border.color: Qt.rgba(Style.palette.color1.r, Style.palette.color1.g, Style.palette.color1.b, 0.25)

    Rectangle {
        id: bgMask
        anchors.fill: parent
        radius: parent.radius
        visible: false
    }

    ShaderEffect {
        anchors.fill: parent
        fragmentShader: Assets.shaders.waves

        property real time: 0

        NumberAnimation on time {
            from: 0
            to: Math.PI * 2
            duration: 10000
            loops: Animation.Infinite
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: bgMask
        }
    }
}
