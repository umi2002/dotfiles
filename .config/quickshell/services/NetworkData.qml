pragma Singleton

import Quickshell
import QtQuick
import QtQml
import Quickshell.Networking

import qs.assets

Singleton {
    id: root

    property var pendingPsk: ({})

    readonly property int connectivity: Networking.connectivity
    property bool portalOpened: false

    function handleConnectivity() {
        if (connectivity === NetworkConnectivity.Portal) {
            if (!portalOpened) {
                portalOpened = true;
                Quickshell.execDetached(["uwsm", "app", "--", "xdg-open", "http://ping.archlinux.org/nm-check.txt"]);
            }
        } else if (connectivity === NetworkConnectivity.Full || connectivity === NetworkConnectivity.None) {
            portalOpened = false;
        }
    }

    onConnectivityChanged: handleConnectivity()
    Component.onCompleted: handleConnectivity()

    readonly property ScriptModel knownNetworks: ScriptModel {
        values: root.networks?.filter(network => network.known && !root.pendingPsk[network.name]) ?? []
    }
    readonly property ScriptModel unknownNetworks: ScriptModel {
        values: root.networks?.filter(network => !network.known || root.pendingPsk[network.name]) ?? []
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

    function connectWithPsk(network, psk) {
        if (!network.known)
            pendingPsk = Object.assign({}, pendingPsk, {
                [network.name]: true
            });
        network.connectWithPsk(psk);
    }

    function isSaved(network) {
        return network?.known && !pendingPsk[network.name];
    }

    function rejectPsk(network) {
        if (pendingPsk[network.name])
            network.forget();
    }

    function clearPending(name) {
        if (!pendingPsk[name])
            return;
        const pending = Object.assign({}, pendingPsk);
        delete pending[name];
        pendingPsk = pending;
    }

    Instantiator {
        model: root.networks ?? []

        delegate: Connections {
            required property var modelData
            target: modelData

            function onConnectionFailed(reason) {
                root.rejectPsk(modelData);
            }

            function onConnectedChanged() {
                if (modelData.connected)
                    root.clearPending(modelData.name);
            }

            function onKnownChanged() {
                if (!modelData.known)
                    root.clearPending(modelData.name);
            }
        }
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
