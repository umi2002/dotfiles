pragma ComponentBehavior: Bound

import Quickshell.Io
import QtQuick

import qs
import qs.services

Rectangle {
    id: root

    required property var service

    readonly property bool failed: Systemd.isFailed(root.service)
    property string logText: ""

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
            implicitHeight: logOutput.implicitHeight + Style.spacing.normal * 2
            visible: root.failed && root.logText.length > 0
            radius: Style.radius.small
            color: Style.palette.crust

            Text {
                id: logOutput

                anchors.fill: parent
                anchors.margins: Style.spacing.normal
                text: root.logText
                wrapMode: Text.Wrap
                font.pointSize: Style.font.size2
                font.family: Style.font.family2
                color: Style.palette.subtext0
            }
        }
    }
}
