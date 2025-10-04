pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQml.Models

Singleton {
    id: root

    property ListModel knownNetworks: ListModel {}
    property ListModel unknownNetworks: ListModel {}
    property var savedNetworks: new Set()
    property string status: ""
    readonly property bool isWiFiOn: status !== "unavailable"
    property string connectedNetwork: ""
    property string connectedNetworkInfo: ""
    property string networkStrength: ""
    property string networkIcon: ""
    property string wifiDevice: ""

    signal fetchedNetwork
    signal statusSet

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
            let currentIndex = -1;
            for (let i = 0; i < model.count; i++) {
                if (model.get(i).ssid === network.ssid) {
                    currentIndex = i;
                    break;
                }
            }

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

    function setIcon() {
        if (status === "unavailable") {
            networkIcon = "../assets/wifi_off_icon.svg";
            return;
        }

        if (status === "disconnected") {
            networkIcon = "../assets/missing_wifi_icon.svg";
            return;
        }

        let intNetworkStrength = parseInt(networkStrength);
        if (intNetworkStrength > 80) {
            networkIcon = "../assets/wifi_4_bar_icon.svg";
        } else if (intNetworkStrength > 60) {
            networkIcon = "../assets/wifi_3_bar_icon.svg";
        } else if (intNetworkStrength > 40) {
            networkIcon = "../assets/wifi_2_bar_icon.svg";
        } else {
            networkIcon = "../assets/wifi_1_bar_icon.svg";
        }
    }

    function toggleWiFi() {
        toggleWiFiProcess.running = true;
    }

    Process {
        id: getStatus
        command: ["nmcli", "-g", "TYPE,STATE", "d"]
        stdout: StdioCollector {
            onStreamFinished: {
                let pattern = "^wifi:(.*)$";
                let regex = new RegExp(pattern, "m");
                let match = regex.exec(text);

                root.status = match[1] || "unavailable";
                root.setIcon();
                root.statusSet();
                getSavedConnections.running = true;
            }
        }
    }

    Process {
        id: getSavedConnections
        command: ["nmcli", "-g", "NAME", "connection", "show"]
        stdout: StdioCollector {
            onStreamFinished: {
                let savedNetworks = text.trim().split('\n').map(n => {
                    return n.replace(/ \[.*\]$/, '');
                });
                root.savedNetworks.clear();
                savedNetworks.filter(n => n).forEach(n => root.savedNetworks.add(n));
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
                let networks = {};
                let lines = text.trim().split('\n');
                lines.forEach(line => {
                    if (line) {
                        let parts = line.split(':');
                        let signal = parseInt(parts[1]) || 0;
                        let ssid = parts[2] || "";

                        if (ssid && (!networks[ssid] || signal > networks[ssid].signal)) {
                            networks[ssid] = {
                                ssid: ssid,
                                signal: signal
                            };
                        }
                    }
                });

                let allNetworks = Object.values(networks).sort((a, b) => b.signal - a.signal);

                let known = allNetworks.filter(n => root.savedNetworks.has(n.ssid));

                if (root.connectedNetwork) {
                    let connectedIndex = known.findIndex(n => n.ssid === root.connectedNetwork);
                    if (connectedIndex > 0) {
                        let connectedNet = known.splice(connectedIndex, 1)[0];
                        known.unshift(connectedNet);
                    }
                }

                let unknown = allNetworks.filter(n => !root.savedNetworks.has(n.ssid));

                root.updateNetworkModel(root.knownNetworks, known);
                root.updateNetworkModel(root.unknownNetworks, unknown);

                let pattern = "^yes:(\\d+):(.*)$";
                let regex = new RegExp(pattern, "m");
                let match = regex.exec(text);

                if (match) {
                    root.connectedNetwork = match[2] || "";
                    root.networkStrength = match[1] || "";
                }

                root.fetchedNetwork();
            }
        }
    }

    Process {
        id: getConnectedNetworkInfo
        command: ["nmcli", "d", "w", "show"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.connectedNetworkInfo = text;
            }
        }
    }

    Process {
        id: toggleWiFiProcess
        command: ["nmcli", "r", "w", root.isWiFiOn ? "off" : "on"]
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

    Process {
        id: getWifiDevice
        command: ["nmcli", "-g", "DEVICE,TYPE", "d", "s"]
        stdout: StdioCollector {
            onStreamFinished: {
                let lines = text.trim().split('\n');
                for (let line of lines) {
                    let parts = line.split(':');
                    if (parts[1] === 'wifi') {
                        root.wifiDevice = parts[0];
                        return;
                    }
                }
            }
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
