pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.components
import qs.services

Rectangle {
    id: root
    required property var device
    required property bool isHovered
    property bool isExpanded
    property bool confirmingForget: false

    readonly property bool isPaired: (device?.paired || device?.bonded) ?? false
    readonly property bool isBusy: (device?.pairing ?? false) || device?.state === BluetoothDeviceState.Connecting || device?.state === BluetoothDeviceState.Disconnecting

    signal actionTriggered
    signal forgetTriggered

    onIsHoveredChanged: {
        if (!isHovered)
            confirmingForget = false;
    }

    Timer {
        id: forgetConfirmTimer
        interval: 3000
        onTriggered: root.confirmingForget = false
    }

    implicitHeight: deviceName.height + 10
    color: "transparent"

    Text {
        id: deviceName
        text: root.device?.deviceName || root.device?.name || ""
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: root.device?.connected ? Style.palette.green : Style.palette.subtext1
    }

    Loader {
        active: root.isBusy
        anchors.right: actionButton.left
        anchors.rightMargin: Style.spacing.normal
        anchors.verticalCenter: parent.verticalCenter

        sourceComponent: Throbber {
            size: 18
            strokeWidth: 2
            throbberColor: Style.palette.mauve
        }
    }

    StyledButton {
        text: root.confirmingForget ? "Confirm" : "Forget"
        textColor: Style.palette.red
        visible: root.isPaired && !root.isBusy
        enabled: root.isHovered
        opacity: root.isHovered ? 1 : 0
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: actionButton.left
        anchors.rightMargin: Style.spacing.normal

        Behavior on opacity {
            NumberAnimation {
                duration: Style.animation.normal
            }
        }

        onClicked: {
            if (root.confirmingForget) {
                root.confirmingForget = false;
                forgetConfirmTimer.stop();
                root.forgetTriggered();
            } else {
                root.confirmingForget = true;
                forgetConfirmTimer.restart();
            }
        }
    }

    ActionButton {
        id: actionButton
        isHovered: root.isHovered
        isConnecting: root.isBusy
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: caret.left
        anchors.rightMargin: Style.spacing.normal

        text: {
            if (root.device?.pairing)
                return "Cancel";
            if (!root.isPaired)
                return "Pair";
            return root.device?.connected ? "Disconnect" : "Connect";
        }

        onActionTriggered: {
            root.actionTriggered();
        }
    }

    Loader {
        id: caret
        active: root.isPaired
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        sourceComponent: ExpandCaret {
            isExpanded: root.isExpanded
            onToggled: {
                root.isExpanded = !root.isExpanded;
            }
        }
    }
}
