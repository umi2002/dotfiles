pragma ComponentBehavior: Bound

import QtQuick

import qs.services

Rectangle {
    id: root
    required property var network
    required property bool isHovered
    readonly property bool isConnectedNetwork: network.ssid === Network.connectedNetwork

    clip: true
    implicitHeight: networkHeader.implicitHeight + (networkHeader.isExpanded ? networkInfoLoader.implicitHeight + networkAuthenticateLoader.implicitHeight + 20 : 0)
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
                return;
            }

            if (root.network.requiresPassword && !isExpanded) {
                isExpanded = true;
            } else {
                isExpanded = false;
            }
        }
    }

    Loader {
        id: networkInfoLoader
        active: root.isConnectedNetwork
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: networkHeader.bottom
        anchors.topMargin: 20
        opacity: networkHeader.isExpanded ? 1 : 0
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.InOutCubic
            }
        }

        sourceComponent: NetworkInfo {}
    }

    Loader {
        id: networkAuthenticateLoader
        active: !root.isConnectedNetwork
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: networkHeader.bottom
        anchors.topMargin: 20
        opacity: networkHeader.isExpanded ? 1 : 0
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.InOutCubic
            }
        }

        sourceComponent: NetworkAuthenticate {}
    }
}
