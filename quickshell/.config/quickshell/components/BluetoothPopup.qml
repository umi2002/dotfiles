import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs
import qs.components
import qs.services

ColumnLayout {
    spacing: 30

    WrapperMouseArea {
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            BluetoothData.bluetoothToggle();
        }

        RowLayout {
            Text {
                text: "Bluetooth"
                font.pointSize: Style.font.size1
                font.family: Style.font.family1
                color: Style.palette.color1
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }

            Switch {
                id: bluetoothToggle
                checked: BluetoothData.state !== 0
                enabled: false
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                indicator: Rectangle {
                    readonly property int margins: 2

                    implicitWidth: 40 + margins
                    implicitHeight: 25
                    anchors.centerIn: parent
                    radius: implicitHeight / 2
                    color: bluetoothToggle.checked ? Style.palette.border1 : Style.palette.background2

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        implicitWidth: 20
                        implicitHeight: 20
                        radius: implicitWidth / 2
                        color: Style.palette.color1
                        x: bluetoothToggle.checked ? parent.width - width - parent.margins : parent.margins

                        Behavior on x {
                            NumberAnimation {
                                duration: 200
                            }
                        }
                    }
                }
            }
        }
    }

    ColumnLayout {
        opacity: bluetoothToggle.checked ? 1 : 0
        spacing: 10

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }

        Text {
            text: "Paired Devices"
            font.pointSize: Style.font.size1
            font.family: Style.font.family1
            color: Style.palette.color1
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        BluetoothListView {
            model: BluetoothData.pairedDevices
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
        }
    }
}
