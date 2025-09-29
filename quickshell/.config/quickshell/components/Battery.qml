pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes

import "../Style.js" as Style

/**
 * Material 3 circular progress. See https://m3.material.io/components/progress-indicators/specs
 */
RowLayout {
    id: root
    required property real value
    required property string color
    required property bool isCharging

    Item {
        id: icon

        readonly property int implicitSize: 35
        readonly property int lineWidth: 4

        property real degree: root.value * 360
        property real centerX: width / 2
        property real centerY: height / 2
        property real arcRadius: implicitSize / 2 - lineWidth
        property real gapAngle: 360 / 18
        property real startAngle: -90

        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        Layout.preferredWidth: implicitSize
        Layout.preferredHeight: implicitSize
        opacity: (root.value / 2) + 0.5

        Shape {
            anchors.fill: parent
            layer.enabled: true
            layer.smooth: true
            preferredRendererType: Shape.CurveRenderer

            ShapePath {
                id: secondaryPath
                strokeColor: Style.palette.background2
                strokeWidth: icon.lineWidth
                capStyle: ShapePath.RoundCap
                fillColor: "transparent"

                PathAngleArc {
                    centerX: icon.centerX
                    centerY: icon.centerY
                    radiusX: icon.arcRadius
                    radiusY: icon.arcRadius
                    startAngle: icon.startAngle - icon.gapAngle
                    sweepAngle: -(360 - icon.degree - 2 * icon.gapAngle)
                }
            }

            ShapePath {
                id: primaryPath
                strokeColor: root.color
                strokeWidth: icon.lineWidth
                capStyle: ShapePath.RoundCap
                fillColor: "transparent"

                PathAngleArc {
                    centerX: icon.centerX
                    centerY: icon.centerY
                    radiusX: icon.arcRadius
                    radiusY: icon.arcRadius
                    startAngle: icon.startAngle
                    sweepAngle: -icon.degree
                }
            }

            IconImage {
                id: image
                readonly property string icon: root.isCharging ? "../assets/charging_icon.svg" : "../assets/discharging_icon.svg"
                source: Qt.resolvedUrl(image.icon)
                anchors.centerIn: parent
                implicitSize: 20

                layer.enabled: true
                layer.effect: MultiEffect {
                    colorization: 1
                    colorizationColor: root.color
                }
            }
        }
    }

    Text {
        text: (root.value * 100).toString() + "%"
        font.pointSize: Style.font.size2
        font.family: Style.font.family
        color: root.color
    }
}
