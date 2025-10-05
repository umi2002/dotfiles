pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

import qs
import qs.services

IconImage {
    id: root
    property string color
    source: Qt.resolvedUrl(Network.networkIcon)

    layer.enabled: true
    layer.effect: MultiEffect {
        colorization: 1
        colorizationColor: root.color
    }

    Connections {
        target: Network
        function onStatusSet() {
            if (Network.status === "connected") {
                root.color = Style.palette.color2;
                return;
            }

            if (Network.status === "disconnected") {
                root.color = Style.palette.color1;
                return;
            }

            root.color = Style.palette.color3;
        }
    }
}
