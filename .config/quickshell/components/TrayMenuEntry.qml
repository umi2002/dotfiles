pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick

import qs

Item {
    id: root

    required property var entry
    property int indent: 0
    property bool submenuOpen: false

    signal activated

    implicitWidth: label.implicitWidth + indent + 70
    implicitHeight: 32

    Rectangle {
        anchors.fill: parent
        radius: Style.radius.small
        color: mouseArea.containsMouse && (root.entry?.enabled ?? true) ? Style.palette.surface0 : "transparent"

        Text {
            id: check
            anchors.left: parent.left
            anchors.leftMargin: Style.spacing.small + root.indent
            anchors.verticalCenter: parent.verticalCenter
            visible: (root.entry?.buttonType ?? QsMenuButtonType.None) !== QsMenuButtonType.None
            text: (root.entry?.checkState ?? Qt.Unchecked) === Qt.Unchecked ? "" : ""
            font.family: Style.font.family2
            font.pointSize: Style.font.size2
            color: Style.palette.mauve
        }

        IconImage {
            id: entryIcon
            anchors.left: parent.left
            anchors.leftMargin: Style.spacing.small + root.indent
            anchors.verticalCenter: parent.verticalCenter
            implicitSize: 16
            visible: !check.visible && (root.entry?.icon ?? "") !== ""
            source: root.entry?.icon ?? ""
        }

        Text {
            id: label
            anchors.left: check.visible ? check.right : entryIcon.visible ? entryIcon.right : parent.left
            anchors.leftMargin: Style.spacing.small + (check.visible || entryIcon.visible ? 0 : root.indent)
            anchors.verticalCenter: parent.verticalCenter
            text: (root.entry?.text ?? "").replace(/&&/g, "&").replace(/&(?=\w)/g, "")
            font.family: Style.font.family1
            font.pointSize: Style.font.size2
            color: (root.entry?.enabled ?? true) ? Style.palette.text : Style.palette.overlay1
        }

        ExpandCaret {
            anchors.right: parent.right
            anchors.rightMargin: Style.spacing.small
            anchors.verticalCenter: parent.verticalCenter
            visible: root.entry?.hasChildren ?? false
            isExpanded: root.submenuOpen
            onToggled: root.activated()
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            enabled: root.entry?.enabled ?? true
            cursorShape: Qt.PointingHandCursor
            onClicked: root.activated()
        }
    }
}
