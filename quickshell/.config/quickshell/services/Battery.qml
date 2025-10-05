pragma Singleton

import Quickshell
import Quickshell.Services.UPower

import qs.assets

Singleton {
    readonly property UPowerDevice displayDevice: UPower.displayDevice
    readonly property int chargeState: displayDevice.state
    readonly property bool isCharging: chargeState == UPowerDeviceState.Charging || chargeState == UPowerDeviceState.PendingCharge || chargeState === UPowerDeviceState.FullyCharged
    readonly property int batteryPercent: displayDevice.percentage * 100
    readonly property string batteryIcon: Assets.battery.getIcon(batteryPercent, chargeState)
    readonly property string timeToEmpty: {
        let totalSeconds = displayDevice.timeToEmpty;

        if (!totalSeconds) {
            return "";
        }

        const hours = Math.floor(totalSeconds / 3600);
        const minutes = Math.floor((totalSeconds % 3600) / 60);

        return `${hours}h ${minutes}m left`;
    }
    readonly property string timeToFull: {
        let totalSeconds = displayDevice.timeToFull;

        if (!totalSeconds) {
            return "Fully charged";
        }

        const hours = Math.floor(totalSeconds / 3600);
        const minutes = Math.floor((totalSeconds % 3600) / 60);

        return `${hours}h ${minutes}m until full`;
    }
}
