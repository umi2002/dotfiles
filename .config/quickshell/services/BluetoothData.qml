pragma Singleton

import Quickshell
import Quickshell.Bluetooth

import qs.assets

Singleton {
    id: root

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property list<BluetoothDevice> devices: adapter?.devices?.values ?? []

    readonly property ScriptModel pairedDevices: ScriptModel {
        values: [...root.devices]
    }
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

    function bluetoothToggle() {
        if (!adapter)
            return;
        adapter.enabled = !adapter.enabled;
    }
}
