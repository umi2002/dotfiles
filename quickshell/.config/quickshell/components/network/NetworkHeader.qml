pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.components

Rectangle {
    id: root
    required property string networkName
    required property bool isConnected
    required property bool isHovered
    required property bool isConnecting
    property bool isExpanded

    signal actionTriggered

    implicitHeight: networkName.height + 10
    color: "transparent"

    Text {
        id: networkName
        text: root.networkName
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: root.isConnected ? Style.palette.color2 : Style.palette.color1
    }

    NetworkActionButton {
        isConnected: root.isConnected
        isHovered: root.isHovered
        isConnecting: root.isConnecting
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: caret.left
        anchors.rightMargin: 10

        onActionTriggered: {
            root.actionTriggered();
        }
    }

    Loader {
        id: caret
        active: root.isConnected
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
