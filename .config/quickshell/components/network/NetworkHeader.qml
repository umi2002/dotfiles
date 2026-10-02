pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.assets
import qs.components

Rectangle {
    id: root
    required property var network
    required property bool isHovered
    required property bool isConnecting
    property bool isExpanded
    property bool isSaved: false
    property bool confirmingForget: false

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

    implicitHeight: networkName.height + 10
    color: "transparent"

    Text {
        id: networkName
        text: root.network?.name || ""
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: root.network?.connected ? Style.palette.green : Style.palette.subtext1
    }

    Loader {
        active: root.isConnecting
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
        visible: root.isSaved && !root.isConnecting
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
        revealed: root.isHovered || root.isConnecting
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: caret.left
        anchors.rightMargin: Style.spacing.normal

        icon: {
            if (root.network?.connected)
                return Assets.actions.linkOff;
            if (root.isConnecting || root.isExpanded)
                return Assets.actions.close;
            return Assets.actions.link;
        }
        iconColor: root.network?.connected ? Style.palette.red : Style.palette.green

        onActionTriggered: {
            root.actionTriggered();
        }
    }

    Loader {
        id: caret
        active: root.network?.connected || false
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
