pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

IconImage {
    id: root
    required property string iconSource
    required property color iconColor

    source: iconSource

    layer.enabled: true
    layer.effect: MultiEffect {
        colorization: 1
        colorizationColor: root.iconColor
    }
}
