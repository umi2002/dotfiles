import QtQuick

import qs
import qs.services

Rectangle {
    id: root
    property bool isExpanded

    implicitWidth: 600
    implicitHeight: 600

    border.width: 1
    border.color: Qt.rgba(Style.palette.color1.r, Style.palette.color1.g, Style.palette.color1.b, 0.6)
    radius: 10
    clip: true

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: Qt.rgba(Style.palette.background1.r, Style.palette.background1.g, Style.palette.background1.b, 0.88)
        }
        GradientStop {
            position: 1.0
            color: Qt.rgba(Style.palette.background2.r, Style.palette.background2.g, Style.palette.background2.b, 0.85)
        }
    }

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
