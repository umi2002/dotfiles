pragma ComponentBehavior: Bound

import QtQuick
import Qt5Compat.GraphicalEffects

import qs.assets

Rectangle {
    radius: 10

    color: "transparent"

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
