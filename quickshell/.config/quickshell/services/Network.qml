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
    property string connectedNetwork: ""
    property string networkStrength: ""
    property string networkIcon: ""

    signal fetchedNetwork
    signal statusSet

    function updateNetworkModel(model, newNetworks) {
        for (let i = model.count - 1; i >= 0; i--) {
            let existingSSID = model.get(i).ssid;
            let found = newNetworks.some(n => n.ssid === existingSSID);
            if (!found) {
                model.remove(i);
            }
        }

        newNetworks.forEach((network, index) => {
            let existingIndex = -1;
            for (let i = 0; i < model.count; i++) {
                if (model.get(i).ssid === network.ssid) {
                    existingIndex = i;
                    break;
                }
            }

            if (existingIndex === -1) {
                model.insert(index, network);
            } else if (existingIndex !== index) {
                model.move(existingIndex, index, 1);
                model.set(index, network);
            } else {
                model.set(index, network);
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
            }
        }
    }

    Process {
        id: getSavedConnections
        command: ["nmcli", "-g", "NAME", "connection", "show"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.savedNetworks = new Set(text.trim().split('\n').filter(n => n));
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

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            getStatus.running = true;
            getSavedConnections.running = true;
            getConnections.running = true;
        }
    }

    Component.onCompleted: {
        getStatus.running = true;
        getSavedConnections.running = true;
    }

    onStatusChanged: {
        if (status === "unavailable") {
            return;
        }

        getConnections.running = true;
    }

    onFetchedNetwork: {
        setIcon();
    }
}
