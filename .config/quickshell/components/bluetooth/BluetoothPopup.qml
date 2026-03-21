pragma ComponentBehavior: Bound

import QtQuick.Layouts

import qs.services

ColumnLayout {
    spacing: 30

    BluetoothPopupHeader {
        id: header
    }

    BluetoothSection {
        title: "Paired Devices"
        bluetoothModel: BluetoothData.pairedDevices
        isVisible: BluetoothData.state !== 0
    }
}
