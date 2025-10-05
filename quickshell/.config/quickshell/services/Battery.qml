pragma Singleton
import Quickshell
import Quickshell.Services.UPower
import qs.assets

Singleton {
    id: root

    readonly property UPowerDevice displayDevice: UPower.displayDevice
    readonly property int chargeState: displayDevice.state
    readonly property int batteryPercent: Math.round(displayDevice.percentage * 100)

    readonly property bool isCharging: chargeState === UPowerDeviceState.Charging || chargeState === UPowerDeviceState.PendingCharge
    readonly property bool isFullyCharged: chargeState === UPowerDeviceState.FullyCharged
    readonly property bool isPluggedIn: isCharging || isFullyCharged

    readonly property string batteryIcon: Assets.battery.getIcon(batteryPercent, chargeState)

    readonly property string timeRemaining: isCharging ? timeToFull : timeToEmpty

    readonly property string timeToEmpty: formatTimeRemaining(displayDevice.timeToEmpty, false)
    readonly property string timeToFull: formatTimeRemaining(displayDevice.timeToFull, true)

    function formatTimeRemaining(totalSeconds: real, isCharging: bool): string {
        if (!totalSeconds || totalSeconds <= 0) {
            return isCharging ? "Fully charged" : "";
        }

        const hours = Math.floor(totalSeconds / 3600);
        const minutes = Math.floor((totalSeconds % 3600) / 60);

        const timeParts = [];
        if (hours > 0)
            timeParts.push(`${hours}h`);
        if (minutes > 0)
            timeParts.push(`${minutes}m`);

        const timeStr = timeParts.join(' ');
        return isCharging ? `${timeStr} until full` : `${timeStr} left`;
    }

    readonly property string statusText: {
        if (isFullyCharged)
            return "Fully charged";
        if (isCharging)
            return `Charging • ${batteryPercent}%`;
        return `${batteryPercent}%`;
    }

    readonly property bool isBatteryLow: batteryPercent <= 20 && !isPluggedIn
    readonly property bool isBatteryCritical: batteryPercent <= 10 && !isPluggedIn
}
