pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.components

import qs.services

ColumnLayout {
    spacing: Style.spacing.large

    Component.onCompleted: BluetoothData.setDiscovering(true)
    Component.onDestruction: BluetoothData.setDiscovering(false)

    ToggleHeader {
        id: header

        label: "Bluetooth"
        checked: BluetoothData.state !== 0
        onToggled: BluetoothData.bluetoothToggle()
    }

    ListSection {
        Layout.fillHeight: true
        title: "Paired Devices"
        sectionModel: BluetoothData.pairedDevices
        delegateComponent: BluetoothListViewItem {
            width: ListView.view.width
        }
        isVisible: BluetoothData.state !== 0
    }

    ListSection {
        Layout.fillHeight: true
        title: BluetoothData.discovering ? "Scanning…" : "Available Devices"
        sectionModel: BluetoothData.availableDevices
        delegateComponent: BluetoothListViewItem {
            width: ListView.view.width
        }
        isVisible: BluetoothData.state !== 0
    }
}
