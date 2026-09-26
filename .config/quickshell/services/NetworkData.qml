pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import QtQml
import Quickshell.Networking

Singleton {
    id: root

    property var pendingPsk: ({})

    readonly property int connectivity: Networking.connectivity
    property bool portalOpened: false

    function handleConnectivity() {
        if (connectivity === NetworkConnectivity.Portal) {
            if (!portalOpened) {
                portalOpened = true;
                portalProbe.running = true;
            }
        } else if (connectivity === NetworkConnectivity.Full || connectivity === NetworkConnectivity.None) {
            portalOpened = false;
        }
    }

    function openPortal(url) {
        Quickshell.execDetached(["uwsm", "app", "--", "xdg-open", url]);
    }

    Process {
        id: portalProbe
        command: ["curl", "-sS", "-m", "5", "-o", "/dev/null", "-w", "%{redirect_url}", "http://ping.archlinux.org/nm-check.txt"]

        stdout: StdioCollector {
            onStreamFinished: {
                const redirect = text.trim();
                root.openPortal(redirect.length > 0 ? redirect : "http://neverssl.com");
            }
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

}
