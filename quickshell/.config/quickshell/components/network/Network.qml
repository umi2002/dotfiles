pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Networking

import qs.services

Rectangle {
    id: root
    required property string networkName
    required property bool isHovered

    readonly property var network: NetworkData.findNetwork(root.networkName)

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

        network: root.network
        isHovered: root.isHovered
        isConnecting: root.network?.state === NetworkState.Connecting

        onActionTriggered: {
            if (root.network?.connected) {
                isExpanded = false;
                root.network.disconnect();
                return;
            }

            if (root.network.known || root.network?.security === WifiSecurityType.Open) {
                root.network.connect();
                return;
            }

            networkHeader.isExpanded = !networkHeader.isExpanded;
        }
    }

    Loader {
        id: networkInfoLoader
        active: root.network?.connected || false
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
        active: !root.network?.connected || false
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
