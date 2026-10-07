pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

import qs
import qs.assets
import qs.components
import qs.services

Rectangle {
    id: root

    required property var service

    readonly property bool failed: Systemd.isFailed(root.service)
    property string logText: ""
    property bool copied: false

    function copyLog(): void {
        if (root.logText.length === 0)
            return;
        Quickshell.clipboardText = root.logText;
        root.copied = true;
        copyFeedback.restart();
    }

    implicitHeight: column.implicitHeight
    color: "transparent"

    Process {
        id: logQuery

        running: root.failed
        command: ["journalctl", root.service?.scope ?? "--user", "-u", root.service?.unit ?? "", "-n", "15", "--no-pager", "-o", "cat"]
        stdout: StdioCollector {
            onStreamFinished: root.logText = text.trim()
        }
    }

    Timer {
        id: copyFeedback

        interval: 1500
        onTriggered: root.copied = false
    }

    Column {
        id: column

        width: parent.width
        spacing: Style.spacing.small

        Text {
            width: parent.width
            text: "Status: " + Systemd.statusLabel(root.service)
            wrapMode: Text.WordWrap
            font.pointSize: Style.font.size2
            font.family: Style.font.family3
            color: Style.palette.text
        }

        Text {
            width: parent.width
            text: root.service?.description ?? ""
            visible: text.length > 0
            wrapMode: Text.WordWrap
            font.pointSize: Style.font.size2
            font.family: Style.font.family3
            color: Style.palette.text
        }

        Rectangle {
            width: parent.width
            implicitHeight: Math.max(logOutput.implicitHeight, copyButton.height) + Style.spacing.normal * 2
            visible: root.failed && root.logText.length > 0
            radius: Style.radius.small
            color: Style.palette.crust

            Text {
                id: logOutput

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.right: copyButton.left
                anchors.margins: Style.spacing.normal
                text: root.logText
                wrapMode: Text.Wrap
                font.pointSize: Style.font.size2
                font.family: Style.font.family2
                color: Style.palette.subtext0
            }

            IconActionButton {
                id: copyButton

                icon: root.copied ? Assets.actions.confirm : Assets.actions.copy
                iconColor: root.copied ? Style.palette.green : Style.palette.subtext0
                size: 16
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: Style.spacing.normal

                onActionTriggered: root.copyLog()
            }
        }
    }
}
