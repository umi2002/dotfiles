pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQml.Models

import qs.assets

Singleton {
    id: root

    property ListModel knownNetworks: ListModel {}
    property ListModel unknownNetworks: ListModel {}
    property var savedNetworks: new Set()
    property string status: ""
    property string connectedNetwork: ""
    property string connectedNetworkInfo: ""
    property string networkStrength: ""
    property string networkIcon: ""
    property string wifiDevice: ""

    readonly property bool isWiFiOn: status !== "unavailable"
    readonly property bool isConnecting: connectProcess.running

    signal fetchedNetwork

    function toggleWiFi() {
        toggleWiFiProcess.running = true;
    }

    function disconnect() {
        disconnectProcess.running = true;
    }

    function connect(ssid, password) {
        connectProcess.ssid = ssid;
        connectProcess.password = password;
        connectProcess.running = true;
    }

    function updateNetworkModel(model, newNetworks) {
        let existing = new Map();
        for (let i = 0; i < model.count; i++) {
            existing.set(model.get(i).ssid, i);
        }

        let toKeep = new Set(newNetworks.map(n => n.ssid));

        for (let i = model.count - 1; i >= 0; i--) {
            if (!toKeep.has(model.get(i).ssid)) {
                model.remove(i);
            }
        }

        newNetworks.forEach((network, targetIndex) => {
            let currentIndex = findNetworkIndex(model, network.ssid);

            if (currentIndex === -1) {
                model.insert(targetIndex, network);
            } else {
                if (currentIndex !== targetIndex) {
                    model.move(currentIndex, targetIndex, 1);
                }
                model.set(targetIndex, network);
            }
        });
    }

    function findNetworkIndex(model, ssid) {
        for (let i = 0; i < model.count; i++) {
            if (model.get(i).ssid === ssid) {
                return i;
            }
        }
        return -1;
    }

    function categorizeNetworks(allNetworks, connectedSSID) {
        let known = allNetworks.filter(n => root.savedNetworks.has(n.ssid));
        let unknown = allNetworks.filter(n => !root.savedNetworks.has(n.ssid));

        if (connectedSSID && root.savedNetworks.has(connectedSSID)) {
            let connectedIndex = known.findIndex(n => n.ssid === connectedSSID);
            if (connectedIndex > 0) {
                let [connectedNet] = known.splice(connectedIndex, 1);
                known.unshift(connectedNet);
            }
        }

        return {
            known,
            unknown
        };
    }

    function setIcon() {
        if (status === "unavailable") {
            networkIcon = Assets.wifi.off;
            return;
        }

        if (status === "disconnected") {
            networkIcon = Assets.wifi.missing;
            return;
        }

        networkIcon = getIconForSignalStrength(networkStrength);
    }

    function getIconForSignalStrength(strength) {
        let intStrength = parseInt(strength);
        if (intStrength > 80) {
            return Assets.wifi.bar4;
        } else if (intStrength > 60) {
            return Assets.wifi.bar3;
        } else if (intStrength > 40) {
            return Assets.wifi.bar2;
        } else {
            return Assets.wifi.bar1;
        }
    }

    function parseDeviceStatus(output) {
        let pattern = "^wifi:(.*)$";
        let regex = new RegExp(pattern, "m");
        let match = regex.exec(output);
        return match ? match[1] : "unavailable";
    }

    function parseSavedConnections(output) {
        return output.trim().split('\n').map(n => n.replace(/ \[.*\]$/, '')).filter(n => n);
    }

    function parseAvailableNetworks(output) {
        let networksMap = new Map();
        let connectedSSID = "";
        let connectedSignal = 0;

        let lines = output.trim().split('\n');

        lines.forEach(line => {
            if (!line)
                return;

            let parts = line.split(':');
            let isActive = parts[0] === 'yes';
            let signal = parseInt(parts[1]);
            let ssid = parts.slice(2).join(':');
            let security = parts[parts.length - 1];

            if (!ssid)
                return;

            if (isActive) {
                connectedSSID = ssid;
                connectedSignal = signal;
            }

            let existing = networksMap.get(ssid);
            if (!existing || signal > existing.signal) {
                networksMap.set(ssid, {
                    ssid: ssid,
                    signal: signal,
                    isActive: isActive,
                    requiresPassword: security !== '' && security !== '--'
                });
            }
        });

        return {
            networks: Array.from(networksMap.values()).sort((a, b) => b.signal - a.signal),
            connectedSSID: connectedSSID,
            connectedSignal: connectedSignal
        };
    }

    function parseWiFiDevice(output) {
        let lines = output.trim().split('\n');
        for (let line of lines) {
            let parts = line.split(':');
            if (parts[1] === 'wifi') {
                return parts[0];
            }
        }
        return "";
    }

    Process {
        id: getStatus
        command: ["nmcli", "-g", "TYPE,STATE", "d"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.status = root.parseDeviceStatus(text);
                root.setIcon();
                getSavedConnections.running = true;
            }
        }
    }

    Process {
        id: getSavedConnections
        command: ["nmcli", "-g", "NAME", "connection", "show"]
        stdout: StdioCollector {
            onStreamFinished: {
                let connections = root.parseSavedConnections(text);
                root.savedNetworks.clear();
                connections.forEach(n => root.savedNetworks.add(n));
                getConnections.running = true;
                getConnectedNetworkInfo.running = true;
            }
        }
    }

    Process {
        id: getConnections
        command: ["nmcli", "-g", "ACTIVE,SIGNAL,SSID", "d", "w"]
        stdout: StdioCollector {
            onStreamFinished: {
                let result = root.parseAvailableNetworks(text);

                root.connectedNetwork = result.connectedSSID;
                root.networkStrength = result.connectedSignal.toString();

                let categorized = root.categorizeNetworks(result.networks, result.connectedSSID);
                root.updateNetworkModel(root.knownNetworks, categorized.known);
                root.updateNetworkModel(root.unknownNetworks, categorized.unknown);

                root.fetchedNetwork();
            }
        }
    }

    Process {
        id: getConnectedNetworkInfo
        command: ["nmcli", "d", "w", "show"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.connectedNetworkInfo = text.trim();
            }
        }
    }

    Process {
        id: getWifiDevice
        command: ["nmcli", "-g", "DEVICE,TYPE", "d", "s"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.wifiDevice = root.parseWiFiDevice(text);
            }
        }
    }

    Process {
        id: toggleWiFiProcess
        command: ["nmcli", "r", "w", root.isWiFiOn ? "off" : "on"]
    }

    Process {
        id: disconnectProcess
        command: ["nmcli", "device", "disconnect", root.wifiDevice]
    }

    Process {
        id: connectProcess
        property string ssid: ""
        property string password: ""
        command: {
            let cmd = ["nmcli", "device", "wifi", "connect", ssid];
            if (password) {
                cmd.push("password", password);
            }
            return cmd;
        }
        onExited: {
            connectProcess.password = "";
        }
    }

    Process {
        id: monitorNetwork
        command: ["nmcli", "monitor"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                if (line.includes('wifi') || line.includes(root.wifiDevice)) {
                    getStatus.running = true;
                }
            }
        }
        onExited: {
            running = true;
        }
    }

    Timer {
        id: getConnectionsTimer
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            getConnections.running = true;
        }
    }

    Component.onCompleted: {
        getWifiDevice.running = true;
        monitorNetwork.running = true;
        getStatus.running = true;
    }

    onFetchedNetwork: {
        setIcon();
    }
}
