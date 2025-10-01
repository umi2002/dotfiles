pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import QtQml.Models

Singleton {
    id: root

    property ListModel networks: ListModel {}
    property string status: ""
    property string connectedNetwork: ""
    property string networkStrength: ""
    property string networkIcon: ""

    signal fetchedNetwork
    signal statusSet

    function updateNetworkModel(newNetworks) {
        for (let i = networks.count - 1; i >= 0; i--) {
            let existingSSID = networks.get(i).ssid;
            let found = newNetworks.some(n => n.ssid === existingSSID);
            if (!found) {
                networks.remove(i);
            }
        }

        newNetworks.forEach((network, index) => {
            let existingIndex = -1;
            for (let i = 0; i < networks.count; i++) {
                if (networks.get(i).ssid === network.ssid) {
                    existingIndex = i;
                    break;
                }
            }

            if (existingIndex === -1) {
                networks.insert(index, network);
            } else if (existingIndex !== index) {
                networks.move(existingIndex, index, 1);
                networks.set(index, network); // Update signal strength
            } else {
                networks.set(index, network);
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

                let sortedNetworks = Object.values(networks).sort((a, b) => b.signal - a.signal);
                root.updateNetworkModel(sortedNetworks);

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
            getConnections.running = true;
        }
    }

    Component.onCompleted: {
        getStatus.running = true;
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
