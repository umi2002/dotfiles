import QtQuick
import QtQuick.Shapes

import "../../Style.js" as Style

/**
 * Material 3 circular progress. See https://m3.material.io/components/progress-indicators/specs
 */
Item {
    id: root

    required property real value
    required property int implicitSize
    required property int lineWidth
    required property string color
    required property bool isIconActive

    property real degree: value * 360
    property real centerX: width / 2
    property real centerY: height / 2
    property real arcRadius: root.implicitSize / 2 - root.lineWidth
    property real gapAngle: 360 / 18
    property real startAngle: -90

    implicitWidth: implicitSize
    implicitHeight: implicitSize
    opacity: value

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

        ChargingIcon {
            visible: isCharging
            anchors.centerIn: parent
            color: root.color
            opacity: (root.value / 2) + 0.5
        }

        DischargingIcon {
            visible: !isCharging
            anchors.centerIn: parent
            color: root.color
            opacity: (root.value / 2) + 0.5
        }
    }
}
