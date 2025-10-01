pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    readonly property UPowerDevice displayDevice: UPower.displayDevice
    readonly property int chargeState: displayDevice.state
    readonly property bool isCharging: chargeState == UPowerDeviceState.Charging || chargeState == UPowerDeviceState.PendingCharge
    readonly property int batteryPercent: displayDevice.percentage * 100
    readonly property string batteryIcon: {
        let flooredPercent = Math.floor(batteryPercent / 10) * 10;
        let directory = "../assets/battery_icons";
        let icon;

        switch (chargeState) {
        case UPowerDeviceState.Charging:
            if (flooredPercent === 100) {
                icon = "battery-level-100-charged-symbolic.svg";
                break;
            }
            icon = `battery-level-${flooredPercent}-charging-symbolic.svg`;
            break;
        case UPowerDeviceState.FullyCharged:
            icon = 'battery-level-100-charged-symbolic.svg';
            break;
        case UPowerDeviceState.Discharging:
            icon = `battery-level-${flooredPercent}-symbolic.svg`;
            break;
        case UPowerDeviceState.Empty:
            icon = 'battery-level-0-symbolic.svg';
            break;
        case UPowerDeviceState.PendingCharge:
            icon = `battery-level-${flooredPercent}-plugged-in-symbolic.svg`;
            break;
        case UPowerDeviceState.PendingDischarge:
            icon = `battery-level-${flooredPercent}-plugged-in-symbolic.svg`;
            break;
        case UPowerDeviceState.Unknown:
        default:
            icon = 'battery-missing-symbolic';
            break;
        }

        return `${directory}/${icon}`;
    }
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
            return "";
        }

        const hours = Math.floor(totalSeconds / 3600);
        const minutes = Math.floor((totalSeconds % 3600) / 60);

        return `${hours}h ${minutes}m until full`;
    }
}
