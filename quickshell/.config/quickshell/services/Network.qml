pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string status: ""
    property string connectedNetwork: ""
    property string networkStrength: ""
    property string networkIcon: ""

    signal fetchedNetwork

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
            }
        }
    }

    Process {
        id: getConnection
        command: ["nmcli", "-g", "ACTIVE,SIGNAL,SSID", "d", "w"]
        stdout: StdioCollector {
            onStreamFinished: {
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
            getConnection.running = true;
        }
    }

    Component.onCompleted: {
        getStatus.running = true;
    }

    onStatusChanged: {
        if (status === "unavailable") {
            return;
        }

        getConnection.running = true;
    }

    onFetchedNetwork: {
        setIcon();
    }
}
