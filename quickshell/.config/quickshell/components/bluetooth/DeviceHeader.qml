pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.components

Rectangle {
    id: root
    required property string deviceName
    required property bool isConnected
    property bool isExpanded

    implicitHeight: deviceName.height + 10
    color: "transparent"

    Text {
        id: deviceName
        text: root.deviceName
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: root.isConnected ? Style.palette.color2 : Style.palette.color1
    }

    Loader {
        id: caretLoader
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
