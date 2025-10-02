import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

Rectangle {
    id: root
    required property bool isExpanded

    implicitWidth: 600
    implicitHeight: root.isExpanded ? 600 : 0
    color: "#bf" + Style.palette.background1.toString().substring(1)
    border.width: 1
    border.color: Style.palette.border1
    radius: 10
    clip: true

    RowLayout {
        id: buttons
        property int selectedIndex: 0

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 30
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        implicitHeight: 100
        spacing: 20

        SystemPopupButton {
            icon: "../assets/wifi_icon.svg"
            isSelected: buttons.selectedIndex === 0
            onClicked: buttons.selectedIndex = 0
        }

        SystemPopupButton {
            icon: "../assets/bluetooth_icon.svg"
            isSelected: buttons.selectedIndex === 1
            onClicked: buttons.selectedIndex = 1
        }

        Item {
            Layout.fillWidth: true
        }
    }

    Rectangle {
        id: separator
        anchors.top: buttons.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 30
        implicitHeight: 1
        color: Style.palette.color1
        opacity: 0.2
    }

    ScrollView {
        id: scrollView
        anchors.top: separator.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 30
        anchors.bottomMargin: 30
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        contentWidth: container.width
        contentHeight: container.height

        Item {
            id: container
            implicitWidth: scrollView.width
            implicitHeight: buttons.selectedIndex === 0 ? networkPopupContainer.height : bluetoothPopupContainer.height

            property int currentIndex: buttons.selectedIndex === 0 ? 0 : 1

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
