pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

import qs
import qs.assets

WrapperMouseArea {
    id: root

    required property bool isExpanded

    signal toggled

    cursorShape: Qt.PointingHandCursor

    onClicked: {
        toggled();
    }

    child: IconImage {
        source: Assets.caretForward
        implicitSize: 30

        layer.enabled: true
        layer.effect: MultiEffect {
            colorization: 1
            colorizationColor: Style.palette.color2
        }

        rotation: root.isExpanded ? 90 : 0

        Behavior on rotation {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }
}
