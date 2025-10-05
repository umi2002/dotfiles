pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.services

WrapperMouseArea {
    id: root
    required property var modelData
    required property int index
    property bool isHovered: false

    hoverEnabled: true

    onEntered: {
        isHovered = true;
    }

    onExited: {
        isHovered = false;
    }

    ColumnLayout {
        Rectangle {
            id: network
            readonly property bool isConnectedNetwork: root.modelData.ssid === Network.connectedNetwork
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

            MouseArea {
                anchors.fill: parent
            }

            Rectangle {
                id: networkNameContainer
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                implicitHeight: networkName.height
                color: "transparent"

                Text {
                    id: networkName
                    text: root.modelData.ssid
                    height: 30
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: Style.font.size2
                    font.family: Style.font.family3
                    color: network.isConnectedNetwork ? Style.palette.color2 : Style.palette.color1
                }

                NetworkActionButton {
                    isConnected: network.isConnectedNetwork
                    isHovered: root.isHovered
                    isConnecting: Network.isConnecting
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: caret.left
                    anchors.rightMargin: 10

                    onActionTriggered: {
                        if (network.isConnectedNetwork) {
                            network.isExpanded = false;
                            Network.disconnect();
                            return;
                        }

                        if (Network.savedNetworks.has(root.modelData.ssid)) {
                            Network.connect(root.modelData.ssid, "");
                        }
                    }
                }

                Loader {
                    id: caret
                    active: network.isConnectedNetwork
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    sourceComponent: ExpandCaret {
                        isExpanded: network.isExpanded
                        onToggled: {
                            network.isExpanded = !network.isExpanded;
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

                sourceComponent: NetworkInfo {
                    infoText: Network.connectedNetworkInfo
                }
            }
        }

        Separator {}
    }
}
