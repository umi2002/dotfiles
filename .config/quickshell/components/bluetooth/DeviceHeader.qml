pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.assets
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

    IconActionButton {
        icon: root.confirmingForget ? Assets.actions.confirm : Assets.actions.remove
        iconColor: Style.palette.red
        visible: root.isPaired && !root.isBusy
        revealed: root.isHovered
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: actionButton.left
        anchors.rightMargin: Style.spacing.normal

        onActionTriggered: {
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

    IconActionButton {
        id: actionButton
        revealed: root.isHovered || root.isBusy
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: caret.left
        anchors.rightMargin: Style.spacing.normal

        icon: {
            if (root.device?.pairing)
                return Assets.actions.close;
            if (!root.isPaired)
                return Assets.actions.addLink;
            return root.device?.connected ? Assets.actions.linkOff : Assets.actions.link;
        }
        iconColor: root.device?.connected ? Style.palette.red : Style.palette.green

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
