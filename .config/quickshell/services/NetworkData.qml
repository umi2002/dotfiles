pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Networking

import qs.assets

Singleton {
    id: root

    readonly property ScriptModel knownNetworks: ScriptModel {
        values: root.networks?.filter(network => network.known) ?? []
    }
    readonly property ScriptModel unknownNetworks: ScriptModel {
        values: root.networks?.filter(network => !network.known) ?? []
    }
    readonly property string networkIcon: {
        if (!wifiDevice)
            return Assets.wifi.missing;
        if (wifiDevice.state === ConnectionState.Unknown)
            return Assets.wifi.off;
        if (wifiDevice.state !== ConnectionState.Connected || !connectedNetwork)
            return Assets.wifi.missing;
        return getIconForSignalStrength(connectedNetwork.signalStrength);
    }

    readonly property bool isWiFiOn: Networking.wifiEnabled
    readonly property var wifiDevice: Networking.devices.values.find(device => {
        return device.type === DeviceType.Wifi;
    })
    readonly property var networks: wifiDevice?.networks?.values
    readonly property var connectedNetwork: networks?.find(network => {
        return network.connected;
    })

    function toggleWiFi() {
        Networking.wifiEnabled = !Networking.wifiEnabled;
    }

    function findNetwork(name) {
        return networks?.find(n => n.name === name) ?? null;
    }

    function getIconForSignalStrength(strength) {
        if (strength > 0.8)
            return Assets.wifi.bar4;
        else if (strength > 0.6)
            return Assets.wifi.bar3;
        else if (strength > 0.4)
            return Assets.wifi.bar2;
        else
            return Assets.wifi.bar1;
    }
}
