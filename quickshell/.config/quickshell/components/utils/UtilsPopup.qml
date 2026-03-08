pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs
import qs.assets
import qs.services

Rectangle {
    id: root

    property bool isExpanded
    readonly property int margins: 20
    readonly property int borderRadius: 10

    implicitWidth: container.implicitWidth + margins
    implicitHeight: container.implicitHeight + margins

    border.width: 1
    border.color: Qt.rgba(Style.palette.color1.r, Style.palette.color1.g, Style.palette.color1.b, 0.6)
    radius: borderRadius
    clip: true

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: Qt.rgba(Style.palette.background1.r, Style.palette.background1.g, Style.palette.background1.b, 0.88)
        }
        GradientStop {
            position: 1.0
            color: Qt.rgba(Style.palette.background2.r, Style.palette.background2.g, Style.palette.background2.b, 0.85)
        }
    }

    Rectangle {
        id: container
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.margins / 2
        implicitWidth: layout.implicitWidth + root.margins
        implicitHeight: layout.implicitHeight + root.margins
        radius: root.borderRadius

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

        ColumnLayout {
            id: layout
            anchors.centerIn: parent

            UtilsSlider {
                value: Brightness.brightnessPercent
                icon: Brightness.brightnessIcon
                setValueCallback: Brightness.setBrightness
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }

            UtilsPopupSeparator {}

            UtilsSlider {
                value: Audio.volume
                icon: Audio.volumeIcon
                setValueCallback: Audio.setVolume
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }
        }
    }
}
