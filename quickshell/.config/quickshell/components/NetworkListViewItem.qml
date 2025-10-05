pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

WrapperMouseArea {
    id: root
    required property var modelData
    required property int index
    property int isHovered

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

                WrapperMouseArea {
                    enabled: !Network.isConnecting
                    opacity: root.isHovered ? (Network.isConnecting ? 0.5 : 1) : 0
                    cursorShape: Network.isConnecting ? Qt.BusyCursor : Qt.PointingHandCursor
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: caret.left
                    anchors.rightMargin: 10

                    onClicked: {
                        pulseAnimation.start();

                        if (network.isConnectedNetwork) {
                            network.isExpanded = false;
                            Network.disconnect();
                            return;
                        }

                        if (Network.savedNetworks.has(root.modelData.ssid)) {
                            Network.connect(root.modelData.ssid, "");
                        }
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 200
                        }
                    }

                    Rectangle {
                        id: button
                        implicitWidth: 100
                        implicitHeight: 30
                        border.width: 1
                        border.color: Style.palette.border1
                        color: "#bf" + Style.palette.background1.toString().substring(1)

                        ColorAnimation on color {
                            id: pulseAnimation
                            from: "#bf" + Style.palette.background1.toString().substring(1)
                            to: Qt.lighter(Style.palette.background1, 1.5)
                            duration: 200
                            running: false

                            onStopped: {
                                reverseAnimation.start();
                            }
                        }

                        ColorAnimation {
                            id: reverseAnimation
                            target: button
                            property: "color"
                            to: "#bf" + Style.palette.background1.toString().substring(1)
                            duration: 200
                            running: false
                        }

                        Text {
                            text: network.isConnectedNetwork ? "Disconnect" : "Connect"
                            horizontalAlignment: Qt.AlignHCenter
                            verticalAlignment: Qt.AlignVCenter
                            anchors.fill: parent
                            font.pointSize: Style.font.size2
                            font.family: Style.font.family3
                            color: Style.palette.color1
                        }
                    }
                }

                WrapperMouseArea {
                    id: caret
                    cursorShape: Qt.PointingHandCursor
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    onClicked: {
                        network.isExpanded = !network.isExpanded;
                    }

                    Loader {
                        active: network.isConnectedNetwork

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
}
