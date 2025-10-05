// Assets.qml
pragma Singleton
import QtQuick

QtObject {
    id: assets

    // Helper function to resolve asset paths
    function resolveAsset(filename: string): url {
        return Qt.resolvedUrl(filename);
    }

    // System icons
    readonly property url archLinux: resolveAsset("arch_linux_icon.svg")

    // Workspace icons
    readonly property var workspace: QtObject {
        readonly property url occupied: assets.resolveAsset("occupied_workspace_icon.svg")
        readonly property url unoccupied: assets.resolveAsset("unoccupied_workspace_icon.svg")
    }

    // Bluetooth icons
    readonly property var bluetooth: QtObject {
        readonly property url default_: assets.resolveAsset("bluetooth_icon.svg")
        readonly property url off: assets.resolveAsset("bluetooth_off_icon.svg")
        readonly property url connected: assets.resolveAsset("bluetooth_connected_icon.svg")
        readonly property url disconnected: assets.resolveAsset("bluetooth_disconnected_icon.svg")
    }

    // WiFi icons
    readonly property var wifi: QtObject {
        readonly property url default_: assets.resolveAsset("wifi_icon.svg")
        readonly property url off: assets.resolveAsset("wifi_off_icon.svg")
        readonly property url missing: assets.resolveAsset("missing_wifi_icon.svg")
        readonly property url bar1: assets.resolveAsset("wifi_1_bar_icon.svg")
        readonly property url bar2: assets.resolveAsset("wifi_2_bar_icon.svg")
        readonly property url bar3: assets.resolveAsset("wifi_3_bar_icon.svg")
        readonly property url bar4: assets.resolveAsset("wifi_4_bar_icon.svg")
        readonly property url caretForward: assets.resolveAsset("caret_forward_icon.svg")
    }

    // Volume icons
    readonly property var volume: QtObject {
        readonly property url off: assets.resolveAsset("volume_off_icon.svg")
        readonly property url low: assets.resolveAsset("volume_low_icon.svg")
        readonly property url medium: assets.resolveAsset("volume_medium_icon.svg")
        readonly property url high: assets.resolveAsset("volume_high_icon.svg")
    }

    // Brightness icons
    readonly property var brightness: QtObject {
        readonly property url low: assets.resolveAsset("brightness_low_icon.svg")
        readonly property url medium: assets.resolveAsset("brightness_medium_icon.svg")
        readonly property url high: assets.resolveAsset("brightness_high_icon.svg")
    }

    // Media control icons
    readonly property var media: QtObject {
        readonly property url play: assets.resolveAsset("play_icon.svg")
        readonly property url pause: assets.resolveAsset("pause_icon.svg")
        readonly property url skipNext: assets.resolveAsset("skip_next_icon.svg")
        readonly property url skipPrevious: assets.resolveAsset("skip_previous_icon.svg")
    }

    // App logos
    readonly property var logos: QtObject {
        readonly property url spotify: assets.resolveAsset("spotify_logo.svg")
    }

    // Battery icons
    readonly property var battery: QtObject {
        readonly property string basePath: "battery_icons/"

        // Special states
        readonly property url action: assets.resolveAsset(basePath + "battery-action-symbolic.svg")
        readonly property url caution: assets.resolveAsset(basePath + "battery-caution-symbolic.svg")
        readonly property url low: assets.resolveAsset(basePath + "battery-low-symbolic.svg")
        readonly property url missing: assets.resolveAsset(basePath + "battery-missing-symbolic.svg")

        // Get battery icon based on percentage and UPowerDeviceState
        function getIcon(batteryPercent: int, chargeState: int): url {
            let flooredPercent = Math.floor(batteryPercent / 10) * 10;
            let icon;

            switch (chargeState) {
            case 1 // UPowerDeviceState.Charging
            :
                if (flooredPercent === 100) {
                    icon = "battery-level-100-charged-symbolic.svg";
                    break;
                }
                icon = `battery-level-${flooredPercent}-charging-symbolic.svg`;
                break;
            case 4 // UPowerDeviceState.FullyCharged
            :
                icon = 'battery-level-100-charged-symbolic.svg';
                break;
            case 2 // UPowerDeviceState.Discharging
            :
                icon = `battery-level-${flooredPercent}-symbolic.svg`;
                break;
            case 3 // UPowerDeviceState.Empty
            :
                icon = 'battery-level-0-symbolic.svg';
                break;
            case 5 // UPowerDeviceState.PendingCharge
            :
                icon = `battery-level-${flooredPercent}-plugged-in-symbolic.svg`;
                break;
            case 6 // UPowerDeviceState.PendingDischarge
            :
                icon = `battery-level-${flooredPercent}-plugged-in-symbolic.svg`;
                break;
            case 0: // UPowerDeviceState.Unknown
            default:
                icon = 'battery-missing-symbolic.svg';
                break;
            }

            return assets.resolveAsset(basePath + icon);
        }
    }
}
