pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.UPower
import QtQuick

import qs.services

Singleton {
    id: root

    readonly property bool isLaptop: Battery.displayDevice.isLaptopBattery
    readonly property bool canBoost: PowerProfiles.hasPerformanceProfile

    function applyDesktopProfile() {
        if (Battery.deviceReady && !isLaptop && canBoost) {
            PowerProfiles.profile = PowerProfile.Performance;
        }
    }

    function applyChargeProfile() {
        if (!isLaptop || !canBoost) {
            return;
        }

        switch (Battery.chargeState) {
        case UPowerDeviceState.Charging:
        case UPowerDeviceState.FullyCharged:
            PowerProfiles.profile = PowerProfile.Performance;
            break;
        case UPowerDeviceState.Discharging:
            if (Battery.batteryPercent < Battery.batteryThreshold) {
                PowerProfiles.profile = PowerProfile.PowerSaver;
            } else {
                PowerProfiles.profile = PowerProfile.Balanced;
            }
            break;
        default:
            PowerProfiles.profile = PowerProfile.Balanced;
            break;
        }
    }

    Component.onCompleted: applyDesktopProfile()

    Connections {
        target: Battery

        function onDeviceReadyChanged() {
            root.applyDesktopProfile();
        }

        function onChargeStateChanged() {
            root.applyChargeProfile();
        }

        function onBatteryPercentChanged() {
            if (Battery.batteryPercent < Battery.batteryThreshold && !Battery.isCharging) {
                PowerProfiles.profile = PowerProfile.PowerSaver;
            }
        }
    }
}
