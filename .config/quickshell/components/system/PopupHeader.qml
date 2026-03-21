import QtQuick
import QtQuick.Layouts

import qs
import qs.assets

Item {
    id: root
    property int selectedIndex: 0

    implicitHeight: buttonRow.implicitHeight

    RowLayout {
        id: buttonRow
        anchors.fill: parent
        spacing: 20

        SystemPopupButton {
            id: wifiButton
            icon: Assets.wifi.default_
            isSelected: root.selectedIndex === 0
            onClicked: root.selectedIndex = 0
        }

        SystemPopupButton {
            id: bluetoothButton
            icon: Assets.bluetooth.default_
            isSelected: root.selectedIndex === 1
            onClicked: root.selectedIndex = 1
        }

        Item {
            Layout.fillWidth: true
        }
    }

    Rectangle {
        anchors.top: parent.bottom
        anchors.topMargin: 10
        implicitHeight: 5
        implicitWidth: root.selectedIndex === 0 ? wifiButton.implicitWidth : bluetoothButton.implicitWidth
        radius: implicitHeight / 2
        color: Style.palette.green
        x: root.selectedIndex === 0 ? wifiButton.x : bluetoothButton.x

        Behavior on x {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on implicitWidth {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }
    }
}
