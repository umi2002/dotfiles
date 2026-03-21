pragma ComponentBehavior: Bound

import Quickshell.Bluetooth

import qs
import qs.components
import qs.services

ColorizedIcon {
    id: root

    iconSource: BluetoothData.icon
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
