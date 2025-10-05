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
            Network.toggleWiFi();
        }

        RowLayout {
            Text {
                text: "Wi-Fi"
                font.pointSize: Style.font.size1
                font.family: Style.font.family1
                color: Style.palette.color1
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }

            Switch {
                id: wifiToggle
                checked: Network.isWiFiOn
                enabled: false
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                indicator: Rectangle {
                    readonly property int margins: 2

                    implicitWidth: 40 + margins
                    implicitHeight: 25
                    anchors.centerIn: parent
                    radius: implicitHeight / 2
                    color: wifiToggle.checked ? Style.palette.border1 : Style.palette.background2

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
                        x: wifiToggle.checked ? parent.width - width - parent.margins : parent.margins

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
        opacity: wifiToggle.checked ? 1 : 0
        spacing: 10

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }

        Text {
            text: "Saved Networks"
            font.pointSize: Style.font.size1
            font.family: Style.font.family1
            color: Style.palette.color1
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        NetworkListView {
            model: Network.knownNetworks
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
        }
    }

    ColumnLayout {
        opacity: wifiToggle.checked ? 1 : 0
        spacing: 10

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }

        Text {
            text: "Available Networks"
            font.pointSize: Style.font.size1
            font.family: Style.font.family1
            color: Style.palette.color1
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
        }

        NetworkListView {
            model: Network.unknownNetworks
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.fillWidth: true
        }
    }
}
