pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

ColumnLayout {
    id: layout
    required property var modelData
    required property int index
    property string connectedNetwork: Network.connectedNetwork

    Rectangle {
        id: network
        readonly property bool isConnectedNetwork: layout.modelData.ssid === Network.connectedNetwork
        property bool isExpanded: false

        clip: true
        Layout.fillWidth: true
        implicitHeight: networkNameContainer.implicitHeight + (isExpanded ? networkInfoLoader.implicitHeight : 0)
        Layout.alignment: Qt.AlignVCenter
        color: "transparent"

        Behavior on implicitHeight {
            NumberAnimation {
                duration: 300
                easing.type: Easing.InOutCubic
            }
        }

        Rectangle {
            id: networkNameContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            implicitHeight: networkName.height + (network.isConnectedNetwork ? 20 : 0)
            color: "transparent"

            MouseArea {
                enabled: network.isConnectedNetwork
                visible: network.isConnectedNetwork
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent

                onClicked: {
                    network.isExpanded = !network.isExpanded;
                }
            }

            Text {
                id: networkName
                text: layout.modelData.ssid
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: Style.font.size2
                font.family: Style.font.family3
                color: network.isConnectedNetwork ? Style.palette.color2 : Style.palette.color1
            }

            Loader {
                id: caretLoader
                active: network.isConnectedNetwork
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                sourceComponent: IconImage {
                    source: Qt.resolvedUrl("../assets/caret_forward_icon.svg")
                    implicitSize: 30

                    layer.enabled: true
                    layer.effect: MultiEffect {
                        colorization: 1
                        colorizationColor: Style.palette.color2
                    }

                    rotation: network.isExpanded ? 90 : 0

                    Behavior on rotation {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutQuad
                        }
                    }
                }
            }
        }

        Loader {
            id: networkInfoLoader
            active: network.isConnectedNetwork
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: networkNameContainer.bottom

            sourceComponent: Rectangle {
                clip: true
                implicitHeight: networkInfo.implicitHeight
                color: "transparent"

                Text {
                    id: networkInfo
                    text: Network.connectedNetworkInfo
                    font.pointSize: Style.font.size2
                    font.family: Style.font.family3
                    color: Style.palette.color1
                }
            }
        }
    }

    Rectangle {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        Layout.topMargin: 10
        Layout.bottomMargin: 10
        Layout.preferredHeight: 1
        color: Style.palette.color1
        opacity: 0.2
    }
}
