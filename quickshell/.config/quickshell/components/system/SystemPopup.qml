import QtQuick

import qs

Rectangle {
    id: root
    property bool isExpanded

    implicitWidth: 600
    implicitHeight: isExpanded ? 600 : 0

    color: "#bf" + Style.palette.background1.toString().substring(1)
    border.width: 1
    border.color: Style.palette.border1
    radius: 10
    clip: true

    Item {
        id: headerContainer
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 30
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        implicitHeight: header.implicitHeight

        PopupHeader {
            id: header
            anchors.fill: parent
        }
    }

    PopupSeparator {
        id: separator
        anchors.top: headerContainer.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 30
    }

    PopupContent {
        anchors.top: separator.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 30
        anchors.bottomMargin: 30
        anchors.leftMargin: 5
        anchors.rightMargin: 5

        selectedIndex: header.selectedIndex
        popupWidth: root.implicitWidth
    }
}
