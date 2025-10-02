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
    color: "#bf" + Style.palette.background1.toString().substring(1)
    border.width: 1
    border.color: Style.palette.border1
    radius: 10

    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.topMargin: 30
        anchors.bottomMargin: 30
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        clip: true
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        contentWidth: container.width
        contentHeight: container.height

        Item {
            id: container
            implicitWidth: scrollView.width
            implicitHeight: root.hoveredComponent === "network" ? networkPopupContainer.height : bluetoothPopupContainer.height

            property int currentIndex: root.hoveredComponent === "network" ? 0 : 1

            Item {
                id: slider
                readonly property int margins: 100

                implicitWidth: parent.implicitWidth
                implicitHeight: parent.implicitHeight
                x: -container.currentIndex * root.implicitWidth

                Behavior on x {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.InOutCubic
                    }
                }

                Rectangle {
                    id: networkPopupContainer
                    height: networkPopup.implicitHeight
                    implicitWidth: container.width - slider.margins
                    x: slider.margins / 2
                    color: "transparent"

                    NetworkPopup {
                        id: networkPopup
                        anchors.fill: parent
                    }
                }

                Rectangle {
                    id: bluetoothPopupContainer
                    height: bluetoothPopup.implicitHeight
                    width: container.width - slider.margins
                    x: root.width + slider.margins / 2
                    color: "transparent"

                    BluetoothPopup {
                        id: bluetoothPopup
                        anchors.fill: parent
                    }
                }
            }
        }
    }
}
