pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.components

import qs.services

ColumnLayout {
    spacing: 30

    Component.onCompleted: BluetoothData.setDiscovering(true)
    Component.onDestruction: BluetoothData.setDiscovering(false)

    ToggleHeader {
        id: header

        label: "Bluetooth"
        checked: BluetoothData.state !== 0
        onToggled: BluetoothData.bluetoothToggle()
    }

    BluetoothSection {
        Layout.fillHeight: true
        title: "Paired Devices"
        bluetoothModel: BluetoothData.pairedDevices
        isVisible: BluetoothData.state !== 0
    }

    BluetoothSection {
        Layout.fillHeight: true
        title: BluetoothData.discovering ? "Scanning…" : "Available Devices"
        bluetoothModel: BluetoothData.availableDevices
        isVisible: BluetoothData.state !== 0
    }
}
