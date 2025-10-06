pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.services

WrapperMouseArea {
    id: root

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

        StyledSwitch {
            id: bluetoothToggle
            checked: BluetoothData.state !== 0
            enabled: false
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }
    }
}
