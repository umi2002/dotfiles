pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

import "../Style.js" as Style

/**
 * Material 3 circular progress. See https://m3.material.io/components/progress-indicators/specs
 */
Item {
    id: root

    required property real value
    required property int implicitSize
    required property int lineWidth
    required property string color
    required property bool isCharging

    property real degree: value * 360
    property real centerX: width / 2
    property real centerY: height / 2
    property real arcRadius: root.implicitSize / 2 - root.lineWidth
    property real gapAngle: 360 / 18
    property real startAngle: -90

    implicitWidth: implicitSize
    implicitHeight: implicitSize
    opacity: (value / 2) + 0.5

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.smooth: true
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            id: secondaryPath
            strokeColor: Style.palette.background2
            strokeWidth: root.lineWidth
            capStyle: ShapePath.RoundCap
            fillColor: "transparent"

            PathAngleArc {
                centerX: root.centerX
                centerY: root.centerY
                radiusX: root.arcRadius
                radiusY: root.arcRadius
                startAngle: root.startAngle - root.gapAngle
                sweepAngle: -(360 - root.degree - 2 * root.gapAngle)
            }
        }

        ShapePath {
            id: primaryPath
            strokeColor: root.color
            strokeWidth: root.lineWidth
            capStyle: ShapePath.RoundCap
            fillColor: "transparent"

            PathAngleArc {
                centerX: root.centerX
                centerY: root.centerY
                radiusX: root.arcRadius
                radiusY: root.arcRadius
                startAngle: root.startAngle
                sweepAngle: -root.degree
            }
        }

        IconImage {
            readonly property string icon: root.isCharging ? "../assets/charging_icon.svg" : "../assets/discharging_icon.svg"
            source: Qt.resolvedUrl(icon)
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
