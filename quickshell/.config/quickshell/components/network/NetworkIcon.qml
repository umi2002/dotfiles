pragma ComponentBehavior: Bound

import Quickshell.Networking
import QtQuick

import qs
import qs.components
import qs.services

ColorizedIcon {
    id: root
    iconSource: NetworkData.networkIcon
    iconColor: getNetworkColor()

    function getNetworkColor() {
        switch (NetworkData.wifiDevice?.state) {
        case DeviceConnectionState.Connected:
            return Style.palette.color2;
        case DeviceConnectionState.Unknown:
            return Style.palette.color3;
        default:
            return Style.palette.color1;
        }
    }
}
