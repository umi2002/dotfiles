pragma ComponentBehavior: Bound

import QtQuick

Rectangle {
    id: root

    property color throbberColor: '#f4981f'
    property int size: 60
    property int strokeWidth: 4
    property real minArcLength: 0.1
    property real maxArcLength: 0.75
    property int velocityDuration: 1333
    property int baseRotationDuration: 2000
    property bool running: true

    width: size
    height: size
    color: "transparent"

    property real angle: 0
    property real baseRotation: 0

    SequentialAnimation on angle {
        loops: Animation.Infinite
        running: root.running

        NumberAnimation {
            from: 0
            to: 360
            duration: root.velocityDuration
            easing.type: Easing.InOutCubic
        }
    }

    NumberAnimation on baseRotation {
        from: 0
        to: 360
        duration: root.baseRotationDuration
        loops: Animation.Infinite
        running: root.running
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(width, height) / 2 - root.strokeWidth;

            var progress = (root.angle % 360) / 360;
            var velocity;
            if (progress < 0.5) {
                velocity = progress * 2;
            } else {
                velocity = (1 - progress) * 2;
            }

            var arcLength = root.minArcLength + velocity * (root.maxArcLength - root.minArcLength);
            var arcAngle = arcLength * Math.PI * 2;
            var rotationOffset = (1 - arcLength) * Math.PI * 2;

            ctx.clearRect(0, 0, width, height);
            ctx.lineCap = "round";
            ctx.lineWidth = root.strokeWidth;

            var steps = 100;
            for (var i = 0; i < steps; i++) {
                var t = i / steps;
                var startAngle = rotationOffset + t * arcAngle;
                var endAngle = rotationOffset + ((i + 1) / steps) * arcAngle;
                var opacity = Math.pow(t, 2);

                ctx.strokeStyle = Qt.rgba(root.throbberColor.r, root.throbberColor.g, root.throbberColor.b, opacity);

                ctx.beginPath();
                ctx.arc(centerX, centerY, radius, startAngle, endAngle);
                ctx.stroke();
            }
        }

        rotation: (root.angle + root.baseRotation) % 360

        Connections {
            target: root
            function onAngleChanged() {
                canvas.requestPaint();
            }
        }
    }
}
