pragma ComponentBehavior: Bound

import QtQuick

import qs.components

StyledButton {
    id: root

    required property bool isConnected
    required property bool isHovered
    required property bool isConnecting

    signal actionTriggered

    text: isConnected ? "Disconnect" : "Connect"
    busy: isConnecting
    opacity: isHovered ? (isConnecting ? 0.5 : 1) : 0

    onClicked: {
        actionTriggered();
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 200
        }
    }
}
