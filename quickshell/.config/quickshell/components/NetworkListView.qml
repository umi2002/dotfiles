pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    id: root
    required property var model

    clip: true
    implicitHeight: networks.implicitHeight + 30
    radius: 20
    color: Style.palette.background2

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutCubic
        }
    }

    ListView {
        id: networks
        model: root.model

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        implicitHeight: contentHeight

        add: Transition {
            NumberAnimation {
                properties: "opacity"
                from: 0
                to: 1
                duration: 500
                easing.type: Easing.InOutCubic
            }
        }

        displaced: Transition {
            NumberAnimation {
                properties: "y"
                duration: 400
                easing.type: Easing.InOutCubic
            }
        }

        remove: Transition {
            NumberAnimation {
                properties: "opacity"
                to: 0
                duration: 300
                easing.type: Easing.InOutCubic
            }
        }

        delegate: ColumnLayout {
            id: layout
            required property var modelData
            required property int index
            anchors.left: parent.left
            anchors.right: parent.right
            property string connectedNetwork: Network.connectedNetwork

            Text {
                readonly property bool isConnectedNetwork: layout.modelData.ssid === Network.connectedNetwork

                text: layout.modelData.ssid
                Layout.fillWidth: true
                font.pointSize: Style.font.size2
                font.family: Style.font.family3
                color: isConnectedNetwork ? Style.palette.color2 : Style.palette.color1
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.topMargin: 10
                Layout.bottomMargin: 10
                Layout.preferredHeight: 1
                color: Style.palette.color1
                opacity: 0.2
            }
        }
    }
}
