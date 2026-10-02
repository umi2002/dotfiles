pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.assets

Item {
    id: root
    property int selectedIndex: 0

    readonly property var tabs: [wifiButton, bluetoothButton, servicesButton]

    implicitHeight: buttonRow.implicitHeight

    RowLayout {
        id: buttonRow
        anchors.fill: parent
        spacing: Style.spacing.large

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

        SystemPopupButton {
            id: servicesButton
            icon: Assets.services.default_
            isSelected: root.selectedIndex === 2
            onClicked: root.selectedIndex = 2
        }

        Item {
            Layout.fillWidth: true
        }
    }

    Rectangle {
        anchors.top: parent.bottom
        anchors.topMargin: Style.spacing.normal
        implicitHeight: 5
        implicitWidth: root.tabs[root.selectedIndex].implicitWidth
        radius: implicitHeight / 2
        color: Style.palette.green
        x: root.tabs[root.selectedIndex].x

        Behavior on x {
            NumberAnimation {
                duration: Style.animation.normal
                easing.type: Easing.InOutQuad
            }
        }
        Behavior on implicitWidth {
            NumberAnimation {
                duration: Style.animation.normal
                easing.type: Easing.InOutQuad
            }
        }
    }
}
