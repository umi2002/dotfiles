pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects

import qs
import qs.components
import qs.services

ColorizedIcon {
    id: root
    iconSource: Network.networkIcon

    Connections {
        target: Network
        function onStatusSet() {
            if (Network.status === "connected") {
                root.iconColor = Style.palette.color2;
                return;
            }

            if (Network.status === "disconnected") {
                root.iconColor = Style.palette.color1;
                return;
            }

            root.iconColor = Style.palette.color3;
        }
    }
}
