import QtQuick

import qs
import qs.services

Rectangle {
    id: root
    property bool isExpanded

    implicitWidth: 600
    implicitHeight: 600

    radius: 10
    clip: true
    color: Style.palette.base

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

    onIsExpandedChanged: {
        if (!NetworkData.wifiDevice) {
            return;
        }

        NetworkData.wifiDevice.scannerEnabled = isExpanded;
    }
}
