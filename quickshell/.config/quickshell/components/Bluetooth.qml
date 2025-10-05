pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick.Effects

import qs
import qs.services

IconImage {
    id: root
    readonly property string color: {
        switch (BluetoothData.state) {
        case 0:
            {
                return Style.palette.color3;
            }
        case 1:
            {
                return Style.palette.color2;
            }
        case 2:
        default:
            {
                return Style.palette.color1;
            }
        }
    }

    source: Qt.resolvedUrl(BluetoothData.icon)

    layer.enabled: true
    layer.effect: MultiEffect {
        colorization: 1
        colorizationColor: root.color
    }
}
