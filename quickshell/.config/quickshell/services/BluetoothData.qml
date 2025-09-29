pragma Singleton

import Quickshell
import Quickshell.Bluetooth

Singleton {
    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property list<BluetoothDevice> devices: adapter?.devices?.values || []
    readonly property int state: {
        if (!adapter?.enabled) {
            return 0;
        }

        let isConnected = devices.some(device => {
            return device.connected;
        });

        if (isConnected) {
            return 1;
        } else {
            return 2;
        }
    }
    readonly property string icon: {
        switch (state) {
        case 0:
        default:
            {
                return "../assets/bluetooth_off_icon.svg";
            }
        case 1:
            {
                return "../assets/bluetooth_connected_icon.svg";
            }
        case 2:
            {
                return "../assets/bluetooth_disconnected_icon.svg";
            }
        }
    }
}
