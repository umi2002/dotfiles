pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick

import qs
import qs.components
import qs.services

ColorizedIcon {
    id: root
    iconSource: Network.networkIcon
    iconColor: getNetworkColor()

    function getNetworkColor() {
        switch (Network.status) {
        case "connected":
            return Style.palette.color2;
        case "disconnected":
            return Style.palette.color1;
        default:
            return Style.palette.color3;
        }
    }
}
