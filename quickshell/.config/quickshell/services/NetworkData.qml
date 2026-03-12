pragma Singleton

import Quickshell
import QtQuick
import QtQml.Models
import Quickshell.Networking

import qs.assets

Singleton {
    id: root

    property ListModel knownNetworks: ListModel {}
    property ListModel unknownNetworks: ListModel {}
    property string networkIcon: ""

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

    onIsWiFiOnChanged: updateNetworksTimer.restart()
    onWifiDeviceChanged: updateNetworksTimer.restart()
    onNetworksChanged: updateNetworksTimer.restart()
    onConnectedNetworkChanged: updateNetworksTimer.restart()

    function findNetwork(name) {
        return networks?.find(n => n.name === name) ?? null;
    }

    function updateNetworkModel(model, newNetworks) {
        let toKeep = new Set(newNetworks.map(n => n.name));

        for (let i = model.count - 1; i >= 0; i--) {
            if (!toKeep.has(model.get(i).name)) {
                model.remove(i);
            }
        }

        newNetworks.forEach((network, targetIndex) => {
            let currentIndex = findNetworkIndex(model, network.name);

            if (currentIndex === -1) {
                model.insert(targetIndex, {
                    name: network.name
                });
            } else {
                if (currentIndex !== targetIndex) {
                    model.move(currentIndex, targetIndex, 1);
                }
            }
        });
    }

    function findNetworkIndex(model, name) {
        for (let i = 0; i < model.count; i++) {
            if (model.get(i).name === name) {
                return i;
            }
        }
        return -1;
    }

    function categorizeNetworks() {
        if (!root.networks) {
            return;
        }

        let knownNetworks = [];
        let unknownNetworks = [];
        for (let network of networks) {
            (network.known ? knownNetworks : unknownNetworks).push(network);
        }

        root.updateNetworkModel(root.knownNetworks, knownNetworks);
        root.updateNetworkModel(root.unknownNetworks, unknownNetworks);
    }

    function setIcon() {
        if (!root.wifiDevice) {
            networkIcon = Assets.wifi.missing;
            return;
        }

        let status = root.wifiDevice.state;

        if (status === DeviceConnectionState.Unknown) {
            networkIcon = Assets.wifi.off;
            return;
        }

        if (status !== DeviceConnectionState.Connected || !root.connectedNetwork) {
            networkIcon = Assets.wifi.missing;
            return;
        }

        networkIcon = getIconForSignalStrength(root.connectedNetwork.signalStrength);
    }

    function getIconForSignalStrength(strength) {
        if (strength > 0.8) {
            return Assets.wifi.bar4;
        } else if (strength > 0.6) {
            return Assets.wifi.bar3;
        } else if (strength > 0.4) {
            return Assets.wifi.bar2;
        } else {
            return Assets.wifi.bar1;
        }
    }

    Timer {
        id: updateNetworksTimer
        interval: 500
        onTriggered: {
            root.categorizeNetworks();
            root.setIcon();
        }
    }
}
