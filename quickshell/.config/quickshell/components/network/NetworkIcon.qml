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
            return Style.palette.green;
        case DeviceConnectionState.Unknown:
            return Style.palette.red;
        default:
            return Style.palette.teal;
        }
    }
}
