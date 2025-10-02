import QtQuick
import QtQuick.Controls

import qs.components
import "../Style.js" as Style

Rectangle {
    id: root
    required property bool isHovered
    required property string hoveredComponent

    implicitWidth: 600
    implicitHeight: root.isHovered ? 600 : 0
    color: Style.palette.background1
    topRightRadius: 10

    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.margins: 30
        clip: true
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        contentWidth: container.width
        contentHeight: container.height

        Item {
            id: container
            width: scrollView.width - 20
            height: root.hoveredComponent === "network" ? networkPopup.height : bluetoothPopup.height

            property int currentIndex: root.hoveredComponent === "network" ? 0 : 1

            Item {
                id: slider
                width: parent.width
                height: parent.height
                x: -container.currentIndex * container.width

                Behavior on x {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.InOutCubic
                    }
                }

                NetworkPopup {
                    id: networkPopup
                    width: container.width
                    x: 0
                }

                BluetoothPopup {
                    id: bluetoothPopup
                    width: container.width
                    x: container.width
                }
            }

            Rectangle {
                id: clippingRectangleLeft
                width: 1000
                height: parent.height
                x: -width
                color: Style.palette.background1
            }

            Rectangle {
                id: clippingRectangleRight
                width: 1000
                height: parent.height
                x: parent.width
                color: Style.palette.background1
            }
        }
    }
}
