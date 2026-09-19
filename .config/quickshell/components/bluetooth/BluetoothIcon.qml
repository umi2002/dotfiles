pragma ComponentBehavior: Bound

import Quickshell.Bluetooth

import qs.assets

import qs
import qs.components
import qs.services

ColorizedIcon {
    id: root

    iconSource: getBluetoothIcon()

    function getBluetoothIcon() {
        switch (BluetoothData.state) {
        case BluetoothData.State.Connected:
            return Assets.bluetooth.connected;
        case BluetoothData.State.Disconnected:
            return Assets.bluetooth.disconnected;
        default:
            return Assets.bluetooth.off;
        }
    }
    iconColor: getBluetoothColor()

    function getBluetoothColor() {
        switch (BluetoothData.state) {
        case 0:
            return Style.palette.red;
        case 1:
            return Style.palette.green;
        default:
            return Style.palette.teal;
        }
    }
}
