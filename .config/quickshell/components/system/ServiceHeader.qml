pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.assets
import qs.components
import qs.services

Rectangle {
    id: root

    required property var service
    required property bool isHovered
    property bool isExpanded

    readonly property bool failed: Systemd.isFailed(root.service)
    readonly property bool running: root.service?.sub === "running"
    readonly property bool busy: Systemd.pendingUnit !== "" && Systemd.pendingUnit === root.service?.unit

    signal actionTriggered(string action)

    implicitHeight: serviceName.height + 10
    color: "transparent"

    ColorizedIcon {
        id: statusIcon

        iconSource: Assets.services.warning
        iconColor: Style.palette.red
        implicitSize: 18
        opacity: root.failed ? 1 : 0
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        id: serviceName

        text: root.service?.unit ?? ""
        anchors.left: statusIcon.right
        anchors.leftMargin: Style.spacing.normal
        anchors.right: restartButton.left
        anchors.rightMargin: Style.spacing.normal
        anchors.verticalCenter: parent.verticalCenter
        elide: Text.ElideRight
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: root.failed ? Style.palette.red : (root.running ? Style.palette.green : Style.palette.subtext1)
    }

    IconActionButton {
        id: restartButton

        icon: Assets.services.restart
        iconColor: Style.palette.text
        revealed: root.isHovered && !root.busy
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: toggleButton.left
        anchors.rightMargin: Style.spacing.normal

        onActionTriggered: root.actionTriggered("restart")
    }

    IconActionButton {
        id: toggleButton

        icon: root.running ? Assets.services.stop : Assets.services.start
        iconColor: root.running ? Style.palette.red : Style.palette.green
        revealed: root.isHovered && !root.busy
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: caret.left
        anchors.rightMargin: Style.spacing.normal

        onActionTriggered: root.actionTriggered(root.running ? "stop" : "start")
    }

    Loader {
        active: root.busy
        anchors.right: caret.left
        anchors.rightMargin: Style.spacing.normal
        anchors.verticalCenter: parent.verticalCenter

        sourceComponent: Throbber {
            size: 18
            strokeWidth: 2
            throbberColor: Style.palette.mauve
        }
    }

    ExpandCaret {
        id: caret

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        isExpanded: root.isExpanded
        onToggled: root.isExpanded = !root.isExpanded
    }
}
