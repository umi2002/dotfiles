pragma ComponentBehavior: Bound

import QtQuick

import qs.components

import qs
import qs.services

StyledPopupContent {
    id: root

    implicitWidth: 600
    implicitHeight: 600


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

    Separator {
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
        anchors.leftMargin: Style.spacing.small
        anchors.rightMargin: Style.spacing.small

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
