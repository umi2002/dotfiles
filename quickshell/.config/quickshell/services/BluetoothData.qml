pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io
import QtQml.Models

Singleton {
    id: root

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property list<BluetoothDevice> devices: adapter?.devices?.values || []
    readonly property ListModel pairedDevices: ListModel {}
    readonly property BluetoothDevice connectedDevice: {
        return devices.find(device => {
            return device.connected;
        }) || null;
    }
    readonly property int state: {
        if (!adapter?.enabled) {
            return 0;
        }

        if (connectedDevice) {
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
    readonly property int batteryPercent: {
        return Math.round(connectedDevice.battery * 100);
    }

    function updateDeviceModel() {
        for (let i = 0; i < pairedDevices.count; i++) {
            let existingAddress = pairedDevices.get(i).address;
            let found = devices.some(d => d.address === existingAddress);
            if (!found) {
                pairedDevices.remove(i);
            }
        }

        devices.forEach((device, index) => {
            let existingIndex = -1;
            for (let i = 0; i < pairedDevices.count; i++) {
                if (pairedDevices.get(i).address === device.address) {
                    existingIndex = i;
                    break;
                }
            }

            if (existingIndex === -1) {
                pairedDevices.insert(index, device);
            } else if (existingIndex !== index) {
                pairedDevices.move(existingIndex, index, 1);
                pairedDevices.set(index, network);
            } else {
                pairedDevices.set(index, network);
            }
        });
    }

    function bluetoothToggle() {
        bluetoothToggleProcess.running = true;
    }

    Process {
        id: bluetoothToggleProcess
        command: ["bluetoothctl", "power", root.adapter.enabled ? "off" : "on"]
    }

    onDevicesChanged: {
        updateDeviceModel();
    }
}
