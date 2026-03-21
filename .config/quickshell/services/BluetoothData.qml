pragma Singleton

import Quickshell
import Quickshell.Bluetooth
import Quickshell.Io
import QtQml.Models

import qs.assets

Singleton {
    id: root

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property list<BluetoothDevice> devices: adapter?.devices?.values ?? []

    readonly property ListModel pairedDevices: ListModel {}
    readonly property BluetoothDevice connectedDevice: findConnectedDevice()

    enum State {
        Disabled = 0,
        Connected = 1,
        Disconnected = 2
    }

    readonly property int state: determineState()
    readonly property string icon: getStateIcon()
    readonly property int batteryPercent: {
        const battery = connectedDevice?.battery;
        if (battery === undefined || battery === null)
            return 0;
        return Math.round(battery * 100);
    }

    function findConnectedDevice() {
        return devices.find(device => device?.connected) ?? null;
    }

    function determineState() {
        if (!adapter?.enabled)
            return BluetoothData.State.Disabled;
        return connectedDevice ? BluetoothData.State.Connected : BluetoothData.State.Disconnected;
    }

    function getStateIcon() {
        switch (state) {
        case BluetoothData.State.Connected:
            return Assets.bluetooth.connected;
        case BluetoothData.State.Disconnected:
            return Assets.bluetooth.disconnected;
        case BluetoothData.State.Disabled:
        default:
            return Assets.bluetooth.off;
        }
    }

    function updateDeviceModel() {
        removeMissingDevices();
        syncDevices();
    }

    function removeMissingDevices() {
        const deviceAddresses = new Set(devices.map(d => d.address));

        for (let i = pairedDevices.count - 1; i >= 0; i--) {
            if (!deviceAddresses.has(pairedDevices.get(i).address)) {
                pairedDevices.remove(i);
            }
        }
    }

    function syncDevices() {
        devices.forEach((device, targetIndex) => {
            const currentIndex = findDeviceIndex(device.address);

            if (currentIndex === -1) {
                insertDevice(targetIndex, device);
            } else if (currentIndex !== targetIndex) {
                moveAndUpdateDevice(currentIndex, targetIndex, device);
            } else {
                updateDevice(targetIndex, device);
            }
        });
    }

    function findDeviceIndex(address) {
        for (let i = 0; i < pairedDevices.count; i++) {
            if (pairedDevices.get(i).address === address) {
                return i;
            }
        }
        return -1;
    }

    function insertDevice(index, device) {
        pairedDevices.insert(index, {
            "address": device.address,
            "name": device.name
        });
    }

    function moveAndUpdateDevice(from, to, device) {
        pairedDevices.move(from, to, 1);
        pairedDevices.set(to, device);
    }

    function updateDevice(index, device) {
        pairedDevices.set(index, device);
    }

    function bluetoothToggle() {
        if (!adapter)
            return;
        bluetoothToggleProcess.running = true;
    }

    Process {
        id: bluetoothToggleProcess
        command: ["bluetoothctl", "power", root.adapter?.enabled ? "off" : "on"]
    }

    onDevicesChanged: updateDeviceModel()
}
