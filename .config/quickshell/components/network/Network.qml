pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Networking

import qs.services

Rectangle {
    id: root
    required property string networkName
    required property bool isHovered

    readonly property var network: NetworkData.findNetwork(root.networkName)
    readonly property bool usesPsk: [WifiSecurityType.WpaPsk, WifiSecurityType.Wpa2Psk, WifiSecurityType.Sae].includes(network?.security)
    property bool pskSubmitted: false
    property bool passwordFailed: false
    property bool cancelled: false
    property string errorText: ""

    function failureMessage(reason) {
        switch (reason) {
        case ConnectionFailReason.NoSecrets:
            return root.pskSubmitted ? "Couldn't connect. Check the password and try again." : "This network needs a password.";
        case ConnectionFailReason.WifiAuthTimeout:
            return "Authentication timed out.";
        case ConnectionFailReason.WifiNetworkLost:
            return "The network is out of range.";
        case ConnectionFailReason.WifiClientFailed:
        case ConnectionFailReason.WifiClientDisconnected:
            return "The Wi-Fi connection failed.";
        default:
            return "Couldn't connect to this network.";
        }
    }

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
        isSaved: NetworkData.isSaved(root.network)
        isConnecting: root.network?.state === ConnectionState.Connecting

        onForgetTriggered: {
            networkHeader.isExpanded = false;
            root.errorText = "";
            root.passwordFailed = false;
            root.network.forget();
        }

        onActionTriggered: {
            if (root.network?.connected) {
                isExpanded = false;
                root.network.disconnect();
                return;
            }

            if (root.network?.state === ConnectionState.Connecting) {
                root.cancelled = true;
                root.errorText = "";
                root.pskSubmitted = false;
                root.passwordFailed = false;
                networkHeader.isExpanded = false;
                root.network.disconnect();
                NetworkData.rejectPsk(root.network);
                return;
            }

            if (networkHeader.isExpanded) {
                networkHeader.isExpanded = false;
                root.passwordFailed = false;
                root.errorText = "";
                return;
            }

            if (NetworkData.isSaved(root.network) || [WifiSecurityType.Open, WifiSecurityType.Owe].includes(root.network?.security)) {
                root.cancelled = false;
                root.errorText = "";
                root.network.connect();
                return;
            }

            root.passwordFailed = false;
            networkHeader.isExpanded = true;
        }
    }

    Connections {
        target: root.network

        function onConnectionFailed(reason) {
            if (root.cancelled) {
                root.cancelled = false;
            } else {
                root.errorText = root.failureMessage(reason);
                if (reason === ConnectionFailReason.NoSecrets)
                    root.passwordFailed = root.pskSubmitted;
                networkHeader.isExpanded = true;
            }
            root.pskSubmitted = false;
        }

        function onConnectedChanged() {
            if (root.network.connected)
                root.errorText = "";
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

        sourceComponent: NetworkAuthenticate {
            failed: root.passwordFailed
            showInput: root.usesPsk
            busy: root.network?.state === ConnectionState.Connecting
            errorText: root.errorText
            onSubmitted: password => {
                if (!root.usesPsk)
                    return;
                root.cancelled = false;
                root.errorText = "";
                root.pskSubmitted = true;
                root.passwordFailed = false;
                NetworkData.connectWithPsk(root.network, password);
            }
        }
    }
}
