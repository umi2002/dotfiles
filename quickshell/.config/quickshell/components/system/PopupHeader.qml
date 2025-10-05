import QtQuick
import QtQuick.Layouts

import qs.assets
import qs.components

RowLayout {
    id: root
    property int selectedIndex: 0

    implicitHeight: 100
    spacing: 20

    SystemPopupButton {
        icon: Assets.wifi.default_
        isSelected: root.selectedIndex === 0
        onClicked: root.selectedIndex = 0
    }

    SystemPopupButton {
        icon: Assets.bluetooth.default_
        isSelected: root.selectedIndex === 1
        onClicked: root.selectedIndex = 1
    }

    Item {
        Layout.fillWidth: true
    }
}
