pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

import qs.components
import qs.services

Item {
    id: root

    property real value: 0
    property color primaryColor: "white"
    property color secondaryColor: "gray"
    property int size: 35
    property int lineWidth: 2

    readonly property real degree: value * 360
    readonly property real centerX: width / 2
    readonly property real centerY: height / 2
    readonly property real arcRadius: size / 2 - lineWidth
    readonly property real gapAngle: 360 / 18
    readonly property real startAngle: -90

    implicitWidth: size
    implicitHeight: size
    opacity: (value / 2) + 0.5

    Shape {
        anchors.fill: parent
        layer.enabled: true
        layer.smooth: true
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            strokeColor: root.secondaryColor
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
            strokeColor: root.primaryColor
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

        ColorizedIcon {
            iconSource: Battery.batteryIcon
            iconColor: root.primaryColor
            anchors.centerIn: parent
            implicitSize: 20
        }
    }
}
