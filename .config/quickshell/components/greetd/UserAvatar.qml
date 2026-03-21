import QtQuick
import Qt5Compat.GraphicalEffects

import qs

Item {
    id: root
    implicitWidth: 150
    implicitHeight: 150

    property string selectedUser: ""

    Rectangle {
        id: mask
        anchors.fill: parent
        radius: Infinity
        visible: false
    }

    Image {
        id: avatarImage
        anchors.fill: parent
        source: root.selectedUser ? `file:///home/${root.selectedUser}/.face` : ""
        fillMode: Image.PreserveAspectCrop
        sourceSize.width: root.width * 2
        sourceSize.height: root.height * 2
        smooth: true
        visible: false
    }

    OpacityMask {
        anchors.fill: parent
        source: avatarImage
        maskSource: mask
        visible: avatarImage.status === Image.Ready
    }

    Rectangle {
        anchors.fill: parent
        radius: Infinity
        color: Style.palette.surface0
        visible: avatarImage.status !== Image.Ready

        Text {
            anchors.centerIn: parent
            text: root.selectedUser ? root.selectedUser[0].toUpperCase() : ""
            font.family: Style.font.family4
            font.pointSize: 30
            color: Style.palette.mauve
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: Infinity
        color: "transparent"
        border.width: 5
        border.color: Style.palette.mauve
    }
}
