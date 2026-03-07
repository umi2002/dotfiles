pragma ComponentBehavior: Bound

import QtQuick
import Qt5Compat.GraphicalEffects

import qs
import qs.assets

Rectangle {
    id: root
    required property var model

    clip: true
    implicitHeight: networks.implicitHeight + 30
    radius: 20
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

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutCubic
        }
    }

    ListView {
        id: networks
        model: root.model

        anchors.fill: parent
        anchors.margins: 20
        implicitHeight: contentHeight
        interactive: false

        add: Transition {
            NumberAnimation {
                properties: "opacity"
                from: 0
                to: 1
                duration: 500
                easing.type: Easing.InOutCubic
            }
        }

        displaced: Transition {
            NumberAnimation {
                properties: "y"
                duration: 400
                easing.type: Easing.InOutCubic
            }
        }

        remove: Transition {
            NumberAnimation {
                properties: "opacity"
                to: 0
                duration: 300
                easing.type: Easing.InOutCubic
            }
        }

        delegate: NetworkListViewItem {
            width: ListView.view.width
        }
    }
}
