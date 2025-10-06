pragma ComponentBehavior: Bound

import QtQuick

import qs.services

Rectangle {
    id: root
    required property var network
    readonly property bool isConnectedNetwork: network.ssid === Network.connectedNetwork
    required property bool isHovered

    clip: true
    implicitHeight: networkHeader.implicitHeight + (networkHeader.isExpanded ? networkInfoLoader.implicitHeight : 0)
    color: "transparent"

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutCubic
        }
    }

    NetworkHeader {
        id: networkHeader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        networkName: root.network.ssid
        isConnected: root.isConnectedNetwork
        isHovered: root.isHovered
        isConnecting: Network.isConnecting

        onActionTriggered: {
            if (root.isConnectedNetwork) {
                isExpanded = false;
                Network.disconnect();
                return;
            }

            if (Network.savedNetworks.has(root.network.ssid)) {
                Network.connect(root.network.ssid, "");
            }
        }
    }

    Loader {
        id: networkInfoLoader
        active: root.isConnectedNetwork
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: networkHeader.bottom

        sourceComponent: NetworkInfo {}
    }
}
