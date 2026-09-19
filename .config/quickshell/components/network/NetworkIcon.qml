pragma ComponentBehavior: Bound

import Quickshell.Networking
import QtQuick

import qs.assets

import qs
import qs.components
import qs.services

ColorizedIcon {
    id: root
    iconSource: getNetworkIcon()
    iconColor: getNetworkColor()

    function getNetworkIcon() {
        const device = NetworkData.wifiDevice;
        if (!device)
            return Assets.wifi.missing;
        if (device.state === ConnectionState.Unknown)
            return Assets.wifi.off;
        if (device.state !== ConnectionState.Connected || !NetworkData.connectedNetwork)
            return Assets.wifi.missing;
        return Assets.wifi.getIcon(NetworkData.connectedNetwork.signalStrength);
    }

    function getNetworkColor() {
        switch (NetworkData.wifiDevice?.state) {
        case ConnectionState.Connected:
            return Style.palette.green;
        case ConnectionState.Unknown:
            return Style.palette.red;
        default:
            return Style.palette.teal;
        }
    }
}
