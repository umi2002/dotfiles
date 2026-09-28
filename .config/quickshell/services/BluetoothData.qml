pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import Quickshell.Bluetooth

Singleton {
    id: root

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property list<BluetoothDevice> devices: adapter?.devices?.values ?? []

    readonly property ScriptModel pairedDevices: ScriptModel {
        values: root.devices.filter(device => device.paired || device.bonded)
    }
    readonly property ScriptModel availableDevices: ScriptModel {
        values: root.devices.filter(device => !device.paired && !device.bonded)
    }
    readonly property bool discovering: adapter?.discovering ?? false
    readonly property BluetoothDevice connectedDevice: findConnectedDevice()

    enum State {
        Disabled = 0,
        Connected = 1,
        Disconnected = 2
    }

    readonly property int state: determineState()
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

    property bool discoveryRequested: false

    function setDiscovering(discovering) {
        discoveryRequested = discovering;
        applyDiscovery();
    }

    function applyDiscovery() {
        if (adapter?.enabled)
            adapter.discovering = discoveryRequested;
    }

    onAdapterChanged: applyDiscovery()

    Connections {
        target: root.adapter

        function onEnabledChanged() {
            root.applyDiscovery();
        }
    }

    function deviceBattery(device) {
        if (!device?.batteryAvailable)
            return -1;
        return Math.round(device.battery * 100);
    }

    function deviceStatus(device) {
        if (device?.pairing)
            return "Pairing";
        if (device?.connected)
            return "Connected";
        if (device?.paired || device?.bonded)
            return "Paired";
        return "Available";
    }

    function bluetoothToggle() {
        if (!adapter)
            return;
        adapter.enabled = !adapter.enabled;
    }
}
