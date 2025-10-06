pragma ComponentBehavior: Bound

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
            return Style.palette.color3;
        case 1:
            return Style.palette.color2;
        case 2:
        default:
            return Style.palette.color1;
        }
    }
}
