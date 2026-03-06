pragma Singleton

import Quickshell
import QtQuick
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

    readonly property var connectedNetwork: {
        if (!wifiDevice || wifiDevice.state !== DeviceConnectionState.Connected) {
            return null;
        }

        return wifiDevice.networks?.values.find(n => n.connected) || null;
    }

    function toggleWiFi() {
        Networking.wifiEnabled = !Networking.wifiEnabled;
    }

    function findNetwork(name) {
        return wifiDevice?.networks?.values.find(n => n.name === name) || null;
    }

    onWifiDeviceChanged: {
        root.knownNetworks.clear();
        root.unknownNetworks.clear();
        if (root.wifiDevice) {
            for (let network of root.wifiDevice.networks.values) {
                root.addToModel(network);
            }
        }
        iconTimer.restart();
    }

    Connections {
        target: root.wifiDevice ? root.wifiDevice.networks : null

        function onObjectInsertedPost(object) {
            root.addToModel(object);
        }

        function onObjectRemovedPost(object) {
            root.removeFromModels(object.name);
        }
    }

    function addToModel(network) {
        let model = network.known ? root.knownNetworks : root.unknownNetworks;
        for (let i = 0; i < model.count; i++) {
            if (model.get(i).name === network.name)
                return;
        }
        model.append({
            name: network.name
        });
    }

    function removeFromModels(name) {
        for (let i = 0; i < root.knownNetworks.count; i++) {
            if (root.knownNetworks.get(i).name === name) {
                root.knownNetworks.remove(i);
                return;
            }
        }
        for (let i = 0; i < root.unknownNetworks.count; i++) {
            if (root.unknownNetworks.get(i).name === name) {
                root.unknownNetworks.remove(i);
                return;
            }
        }
    }

    onConnectedNetworkChanged: {
        if (root.connectedNetwork)
            resyncTimer.restart();
        iconTimer.restart();
    }

    Timer {
        id: resyncTimer
        interval: 1500
        onTriggered: root.resyncKnownStatus()
    }

    function resyncKnownStatus() {
        if (!root.wifiDevice)
            return;
        for (let network of root.wifiDevice.networks.values) {
            let inKnown = false;
            for (let i = 0; i < root.knownNetworks.count; i++) {
                if (root.knownNetworks.get(i).name === network.name) {
                    inKnown = true;
                    break;
                }
            }
            if (network.known && !inKnown) {
                root.removeFromModels(network.name);
                root.knownNetworks.append({
                    name: network.name
                });
            } else if (!network.known && inKnown) {
                root.removeFromModels(network.name);
                root.unknownNetworks.append({
                    name: network.name
                });
            }
        }
    }

    Timer {
        id: iconTimer
        interval: 200
        onTriggered: root.updateIcon()
    }

    function updateIcon() {
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
}
