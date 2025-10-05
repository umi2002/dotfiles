pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import qs
import qs.assets
import qs.services

ColumnLayout {
    id: layout
    required property var modelData
    required property int index

    Rectangle {
        id: bluetoothDevice
        readonly property bool isConnectedDevice: layout.modelData.address === BluetoothData.connectedDevice?.address
        property bool isExpanded: false

        clip: true
        Layout.fillWidth: true
        implicitHeight: bluetoothNameContainer.implicitHeight + (isExpanded ? deviceInfoLoader.implicitHeight : 0)
        Layout.alignment: Qt.AlignVCenter
        color: "transparent"

        Behavior on implicitHeight {
            NumberAnimation {
                duration: 300
                easing.type: Easing.InOutCubic
            }
        }

        Rectangle {
            id: bluetoothNameContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            implicitHeight: deviceName.height + (bluetoothDevice.isConnectedDevice ? 20 : 0)
            color: "transparent"

            MouseArea {
                enabled: bluetoothDevice.isConnectedDevice
                visible: bluetoothDevice.isConnectedDevice
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent

                onClicked: {
                    bluetoothDevice.isExpanded = !bluetoothDevice.isExpanded;
                }
            }

            Text {
                id: deviceName
                text: layout.modelData.name
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: Style.font.size2
                font.family: Style.font.family3
                color: bluetoothDevice.isConnectedDevice ? Style.palette.color2 : Style.palette.color1
            }

            Loader {
                id: caretLoader
                active: bluetoothDevice.isConnectedDevice
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                sourceComponent: IconImage {
                    source: Assets.caretForward
                    implicitSize: 30

                    layer.enabled: true
                    layer.effect: MultiEffect {
                        colorization: 1
                        colorizationColor: Style.palette.color2
                    }

                    rotation: bluetoothDevice.isExpanded ? 90 : 0

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
            id: deviceInfoLoader
            active: bluetoothDevice.isConnectedDevice
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: bluetoothNameContainer.bottom

            sourceComponent: Rectangle {
                clip: true
                implicitHeight: deviceInfo.implicitHeight
                color: "transparent"

                Text {
                    id: deviceInfo
                    text: BluetoothData.batteryPercent.toString() + "% Battery"
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
