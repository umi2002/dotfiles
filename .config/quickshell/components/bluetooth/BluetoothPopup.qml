pragma ComponentBehavior: Bound

import QtQuick.Layouts

import qs.components

import qs.services

ColumnLayout {
    spacing: 30

    ToggleHeader {
        id: header

        label: "Bluetooth"
        checked: BluetoothData.state !== 0
        onToggled: BluetoothData.bluetoothToggle()
    }

    BluetoothSection {
        title: "Paired Devices"
        bluetoothModel: BluetoothData.pairedDevices
        isVisible: BluetoothData.state !== 0
    }
}
