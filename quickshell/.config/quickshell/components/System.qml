import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

WrapperMouseArea {
    id: root
    required property bool popupIsHovered
    readonly property bool isHovered: popupIsHovered || containsMouse
    readonly property string hoveredComponent: {
        if (networkMouseArea.containsMouse) {
            return "network";
        }

        if (bluetoothMouseArea.containsMouse) {
            return "bluetooth";
        }

        return hoveredComponent;
    }
    hoverEnabled: true

    Rectangle {
        id: system
        implicitWidth: layout.width + 20
        implicitHeight: layout.height + 5
        radius: height / 2
        color: Style.palette.background2

        Rectangle {
            implicitWidth: 35
            implicitHeight: 30
            radius: implicitHeight / 2

            anchors.verticalCenter: parent.verticalCenter
            x: {
                if (root.hoveredComponent === "bluetooth") {
                    return layout.x + bluetooth.x + bluetooth.width / 2 - width / 2;
                }

                return layout.x + network.x + network.width / 2 - width / 2;
            }

            Behavior on x {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutCubic
                }
            }
        }

        RowLayout {
            id: layout
            anchors.centerIn: parent
            spacing: 20

            Network {
                id: network
                implicitSize: 30

                MouseArea {
                    id: networkMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }

            Bluetooth {
                id: bluetooth
                implicitSize: 30

                MouseArea {
                    id: bluetoothMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
        }
    }
}
