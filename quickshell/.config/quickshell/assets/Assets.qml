pragma Singleton
import QtQuick

QtObject {
    id: assets

    function resolveAsset(filename: string): url {
        return Qt.resolvedUrl(filename);
    }

    readonly property url archLinux: resolveAsset("arch_linux_icon.svg")
    readonly property url caretForward: assets.resolveAsset("caret_forward_icon.svg")

    readonly property var workspace: QtObject {
        readonly property url occupied: assets.resolveAsset("occupied_workspace_icon.svg")
        readonly property url unoccupied: assets.resolveAsset("unoccupied_workspace_icon.svg")
    }

    readonly property var bluetooth: QtObject {
        readonly property url default_: assets.resolveAsset("bluetooth_icon.svg")
        readonly property url off: assets.resolveAsset("bluetooth_off_icon.svg")
        readonly property url connected: assets.resolveAsset("bluetooth_connected_icon.svg")
        readonly property url disconnected: assets.resolveAsset("bluetooth_disconnected_icon.svg")
    }

    readonly property var wifi: QtObject {
        readonly property url default_: assets.resolveAsset("wifi_icon.svg")
        readonly property url off: assets.resolveAsset("wifi_off_icon.svg")
        readonly property url missing: assets.resolveAsset("missing_wifi_icon.svg")
        readonly property url bar1: assets.resolveAsset("wifi_1_bar_icon.svg")
        readonly property url bar2: assets.resolveAsset("wifi_2_bar_icon.svg")
        readonly property url bar3: assets.resolveAsset("wifi_3_bar_icon.svg")
        readonly property url bar4: assets.resolveAsset("wifi_4_bar_icon.svg")
    }

    readonly property var volume: QtObject {
        readonly property url off: assets.resolveAsset("volume_off_icon.svg")
        readonly property url low: assets.resolveAsset("volume_low_icon.svg")
        readonly property url medium: assets.resolveAsset("volume_medium_icon.svg")
        readonly property url high: assets.resolveAsset("volume_high_icon.svg")
    }

    readonly property var brightness: QtObject {
        readonly property url low: assets.resolveAsset("brightness_low_icon.svg")
        readonly property url medium: assets.resolveAsset("brightness_medium_icon.svg")
        readonly property url high: assets.resolveAsset("brightness_high_icon.svg")
    }

    readonly property var media: QtObject {
        readonly property url play: assets.resolveAsset("play_icon.svg")
        readonly property url pause: assets.resolveAsset("pause_icon.svg")
        readonly property url skipNext: assets.resolveAsset("skip_next_icon.svg")
        readonly property url skipPrevious: assets.resolveAsset("skip_previous_icon.svg")
    }

    readonly property var logos: QtObject {
        readonly property url spotify: assets.resolveAsset("spotify_logo.svg")
    }

    readonly property var ressources: QtObject {
        readonly property url cpu: assets.resolveAsset("cpu.svg")
        readonly property url memory: assets.resolveAsset("memory.svg")
        readonly property url storage: assets.resolveAsset("storage.svg")
    }

    readonly property var battery: QtObject {
        readonly property string basePath: "battery_icons/"

        readonly property url action: assets.resolveAsset(basePath + "battery-action-symbolic.svg")
        readonly property url caution: assets.resolveAsset(basePath + "battery-caution-symbolic.svg")
        readonly property url low: assets.resolveAsset(basePath + "battery-low-symbolic.svg")
        readonly property url missing: assets.resolveAsset(basePath + "battery-missing-symbolic.svg")

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

    readonly property var weather: QtObject {
        readonly property string basePath: "weather_icons/"

        // --- Sky ---
        readonly property url clearDay: assets.resolveAsset(basePath + "wi_clear-day.svg")
        readonly property url clearNight: assets.resolveAsset(basePath + "wi_clear-night.svg")
        readonly property url mostlyClearDay: assets.resolveAsset(basePath + "wi_mostly-clear-day.svg")
        readonly property url mostlyClearNight: assets.resolveAsset(basePath + "wi_mostly-clear-night.svg")
        readonly property url partlyCloudyDay: assets.resolveAsset(basePath + "wi_partly-cloudy-day.svg")
        readonly property url partlyCloudyNight: assets.resolveAsset(basePath + "wi_partly-cloudy-night.svg")
        readonly property url extremeDay: assets.resolveAsset(basePath + "wi_extreme-day.svg")
        readonly property url extremeNight: assets.resolveAsset(basePath + "wi_extreme-night.svg")

        // --- Atmospheric ---
        readonly property url fogDay: assets.resolveAsset(basePath + "wi_fog-day.svg")
        readonly property url fogNight: assets.resolveAsset(basePath + "wi_fog-night.svg")
        readonly property url hazeDay: assets.resolveAsset(basePath + "wi_haze-day.svg")
        readonly property url hazeNight: assets.resolveAsset(basePath + "wi_haze-night.svg")
        readonly property url dustDay: assets.resolveAsset(basePath + "wi_dust-day.svg")
        readonly property url dustNight: assets.resolveAsset(basePath + "wi_dust-night.svg")
        readonly property url dustWind: assets.resolveAsset(basePath + "wi_dust-wind.svg")
        readonly property url tornado: assets.resolveAsset(basePath + "wi_tornado.svg")

        // --- Mostly-clear + precipitation ---
        readonly property url mostlyClearDayDrizzle: assets.resolveAsset(basePath + "wi_mostly-clear-day-drizzle.svg")
        readonly property url mostlyClearDayFog: assets.resolveAsset(basePath + "wi_mostly-clear-day-fog.svg")
        readonly property url mostlyClearDayHail: assets.resolveAsset(basePath + "wi_mostly-clear-day-hail.svg")
        readonly property url mostlyClearDayHaze: assets.resolveAsset(basePath + "wi_mostly-clear-day-haze.svg")
        readonly property url mostlyClearDayRain: assets.resolveAsset(basePath + "wi_mostly-clear-day-rain.svg")
        readonly property url mostlyClearDaySmoke: assets.resolveAsset(basePath + "wi_mostly-clear-day-smoke.svg")
        readonly property url mostlyClearDaySnow: assets.resolveAsset(basePath + "wi_mostly-clear-day-snow.svg")
        // No mostly-clear-day-sleet exists — falls back to partly-cloudy-day-sleet
        readonly property url mostlyClearNightDrizzle: assets.resolveAsset(basePath + "wi_mostly-clear-night-drizzle.svg")
        readonly property url mostlyClearNightFog: assets.resolveAsset(basePath + "wi_mostly-clear-night-fog.svg")
        readonly property url mostlyClearNightHail: assets.resolveAsset(basePath + "wi_mostly-clear-night-hail.svg")
        readonly property url mostlyClearNightHaze: assets.resolveAsset(basePath + "wi_mostly-clear-night-haze.svg")
        readonly property url mostlyClearNightRain: assets.resolveAsset(basePath + "wi_mostly-clear-night-rain.svg")
        readonly property url mostlyClearNightSleet: assets.resolveAsset(basePath + "wi_mostly-clear-night-sleet.svg")
        readonly property url mostlyClearNightSmoke: assets.resolveAsset(basePath + "wi_mostly-clear-night-smoke.svg")
        readonly property url mostlyClearNightSnow: assets.resolveAsset(basePath + "wi_mostly-clear-night-snow.svg")

        // --- Partly-cloudy + precipitation ---
        readonly property url partlyCloudyDayDrizzle: assets.resolveAsset(basePath + "wi_partly-cloudy-day-drizzle.svg")
        readonly property url partlyCloudyDayFog: assets.resolveAsset(basePath + "wi_partly-cloudy-day-fog.svg")
        readonly property url partlyCloudyDayHail: assets.resolveAsset(basePath + "wi_partly-cloudy-day-hail.svg")
        readonly property url partlyCloudyDayHaze: assets.resolveAsset(basePath + "wi_partly-cloudy-day-haze.svg")
        readonly property url partlyCloudyDayRain: assets.resolveAsset(basePath + "wi_partly-cloudy-day-rain.svg")
        readonly property url partlyCloudyDaySleet: assets.resolveAsset(basePath + "wi_partly-cloudy-day-sleet.svg")
        readonly property url partlyCloudyDaySmoke: assets.resolveAsset(basePath + "wi_partly-cloudy-day-smoke.svg")
        readonly property url partlyCloudyDaySnow: assets.resolveAsset(basePath + "wi_partly-cloudy-day-snow.svg")
        readonly property url partlyCloudyNightDrizzle: assets.resolveAsset(basePath + "wi_partly-cloudy-night-drizzle.svg")
        readonly property url partlyCloudyNightFog: assets.resolveAsset(basePath + "wi_partly-cloudy-night-fog.svg")
        readonly property url partlyCloudyNightHail: assets.resolveAsset(basePath + "wi_partly-cloudy-night-hail.svg")
        readonly property url partlyCloudyNightHaze: assets.resolveAsset(basePath + "wi_partly-cloudy-night-haze.svg")
        readonly property url partlyCloudyNightRain: assets.resolveAsset(basePath + "wi_partly-cloudy-night-rain.svg")
        readonly property url partlyCloudyNightSleet: assets.resolveAsset(basePath + "wi_partly-cloudy-night-sleet.svg")
        readonly property url partlyCloudyNightSmoke: assets.resolveAsset(basePath + "wi_partly-cloudy-night-smoke.svg")
        readonly property url partlyCloudyNightSnow: assets.resolveAsset(basePath + "wi_partly-cloudy-night-snow.svg")

        // --- Extreme (mostly cloudy / overcast) + precipitation ---
        readonly property url extremeDayDrizzle: assets.resolveAsset(basePath + "wi_extreme-day-drizzle.svg")
        readonly property url extremeDayFog: assets.resolveAsset(basePath + "wi_extreme-day-fog.svg")
        readonly property url extremeDayHail: assets.resolveAsset(basePath + "wi_extreme-day-hail.svg")
        readonly property url extremeDayHaze: assets.resolveAsset(basePath + "wi_extreme-day-haze.svg")
        readonly property url extremeDayRain: assets.resolveAsset(basePath + "wi_extreme-day-rain.svg")
        readonly property url extremeDaySleet: assets.resolveAsset(basePath + "wi_extreme-day-sleet.svg")
        readonly property url extremeDaySmoke: assets.resolveAsset(basePath + "wi_extreme-day-smoke.svg")
        readonly property url extremeDaySnow: assets.resolveAsset(basePath + "wi_extreme-day-snow.svg")
        readonly property url extremeNightDrizzle: assets.resolveAsset(basePath + "wi_extreme-night-drizzle.svg")
        readonly property url extremeNightFog: assets.resolveAsset(basePath + "wi_extreme-night-fog.svg")
        readonly property url extremeNightHail: assets.resolveAsset(basePath + "wi_extreme-night-hail.svg")
        readonly property url extremeNightHaze: assets.resolveAsset(basePath + "wi_extreme-night-haze.svg")
        readonly property url extremeNightRain: assets.resolveAsset(basePath + "wi_extreme-night-rain.svg")
        readonly property url extremeNightSleet: assets.resolveAsset(basePath + "wi_extreme-night-sleet.svg")
        readonly property url extremeNightSmoke: assets.resolveAsset(basePath + "wi_extreme-night-smoke.svg")
        readonly property url extremeNightSnow: assets.resolveAsset(basePath + "wi_extreme-night-snow.svg")

        // --- Thunderstorms (mostly-clear sky) ---
        readonly property url thunderstormsMostlyClearDay: assets.resolveAsset(basePath + "wi_thunderstorms-day-mostly-clear.svg")
        readonly property url thunderstormsMostlyClearDayDrizzle: assets.resolveAsset(basePath + "wi_thunderstorms-day-mostly-clear-drizzle.svg")
        readonly property url thunderstormsMostlyClearDayRain: assets.resolveAsset(basePath + "wi_thunderstorms-day-mostly-clear-rain.svg")
        readonly property url thunderstormsMostlyClearDaySnow: assets.resolveAsset(basePath + "wi_thunderstorms-day-mostly-clear-snow.svg")
        readonly property url thunderstormsMostlyClearNight: assets.resolveAsset(basePath + "wi_thunderstorms-night-mostly-clear.svg")
        readonly property url thunderstormsMostlyClearNightDrizzle: assets.resolveAsset(basePath + "wi_thunderstorms-night-mostly-clear-drizzle.svg")
        readonly property url thunderstormsMostlyClearNightRain: assets.resolveAsset(basePath + "wi_thunderstorms-night-mostly-clear-rain.svg")
        readonly property url thunderstormsMostlyClearNightSnow: assets.resolveAsset(basePath + "wi_thunderstorms-night-mostly-clear-snow.svg")

        // --- Thunderstorms (extreme / overcast sky) ---
        readonly property url thunderstormsExtremeDay: assets.resolveAsset(basePath + "wi_thunderstorms-day-extreme.svg")
        readonly property url thunderstormsExtremeDayDrizzle: assets.resolveAsset(basePath + "wi_thunderstorms-day-extreme-drizzle.svg")
        readonly property url thunderstormsExtremeDayRain: assets.resolveAsset(basePath + "wi_thunderstorms-day-extreme-rain.svg")
        readonly property url thunderstormsExtremeDaySnow: assets.resolveAsset(basePath + "wi_thunderstorms-day-extreme-snow.svg")
        readonly property url thunderstormsExtremeNight: assets.resolveAsset(basePath + "wi_thunderstorms-night-extreme.svg")
        readonly property url thunderstormsExtremeNightDrizzle: assets.resolveAsset(basePath + "wi_thunderstorms-night-extreme-drizzle.svg")
        readonly property url thunderstormsExtremeNightRain: assets.resolveAsset(basePath + "wi_thunderstorms-night-extreme-rain.svg")
        readonly property url thunderstormsExtremeNightSnow: assets.resolveAsset(basePath + "wi_thunderstorms-night-extreme-snow.svg")

        function getIcon(code: int, isDay: bool, cloudCover: int): url {
            // cl: 0=clear(0-1 oktas), 1=mostly-clear(2-3), 2=partly-cloudy(4-5), 3=extreme(6-8)
            const cl = cloudCover < 0 ? 2 : cloudCover <= 1 ? 0 : cloudCover <= 3 ? 1 : cloudCover <= 5 ? 2 : 3;

            // Sky-only icon driven entirely by cloudiness level
            function skyIcon() {
                if (cl === 0)
                    return isDay ? clearDay : clearNight;
                if (cl === 1)
                    return isDay ? mostlyClearDay : mostlyClearNight;
                if (cl === 2)
                    return isDay ? partlyCloudyDay : partlyCloudyNight;
                return isDay ? extremeDay : extremeNight;
            }

            // Precipitation helpers — each selects the right background tier from cl.
            // Note: no wi_mostly-clear-day-sleet exists, falls back to partly-cloudy-day-sleet.
            function pDrizzle() {
                if (cl <= 1)
                    return isDay ? mostlyClearDayDrizzle : mostlyClearNightDrizzle;
                if (cl === 2)
                    return isDay ? partlyCloudyDayDrizzle : partlyCloudyNightDrizzle;
                return isDay ? extremeDayDrizzle : extremeNightDrizzle;
            }
            function pRain() {
                if (cl <= 1)
                    return isDay ? mostlyClearDayRain : mostlyClearNightRain;
                if (cl === 2)
                    return isDay ? partlyCloudyDayRain : partlyCloudyNightRain;
                return isDay ? extremeDayRain : extremeNightRain;
            }
            function pSnow() {
                if (cl <= 1)
                    return isDay ? mostlyClearDaySnow : mostlyClearNightSnow;
                if (cl === 2)
                    return isDay ? partlyCloudyDaySnow : partlyCloudyNightSnow;
                return isDay ? extremeDaySnow : extremeNightSnow;
            }
            function pHail() {
                if (cl <= 1)
                    return isDay ? mostlyClearDayHail : mostlyClearNightHail;
                if (cl === 2)
                    return isDay ? partlyCloudyDayHail : partlyCloudyNightHail;
                return isDay ? extremeDayHail : extremeNightHail;
            }
            function pSleet() {
                if (cl <= 1)
                    return isDay ? partlyCloudyDaySleet : mostlyClearNightSleet;
                if (cl === 2)
                    return isDay ? partlyCloudyDaySleet : partlyCloudyNightSleet;
                return isDay ? extremeDaySleet : extremeNightSleet;
            }
            function pFog() {
                if (cl <= 1)
                    return isDay ? mostlyClearDayFog : mostlyClearNightFog;
                if (cl === 2)
                    return isDay ? partlyCloudyDayFog : partlyCloudyNightFog;
                return isDay ? extremeDayFog : extremeNightFog;
            }
            function pHaze() {
                if (cl <= 1)
                    return isDay ? mostlyClearDayHaze : mostlyClearNightHaze;
                if (cl === 2)
                    return isDay ? partlyCloudyDayHaze : partlyCloudyNightHaze;
                return isDay ? extremeDayHaze : extremeNightHaze;
            }
            function pSmoke() {
                if (cl <= 1)
                    return isDay ? mostlyClearDaySmoke : mostlyClearNightSmoke;
                if (cl === 2)
                    return isDay ? partlyCloudyDaySmoke : partlyCloudyNightSmoke;
                return isDay ? extremeDaySmoke : extremeNightSmoke;
            }

            // Thunderstorm helpers — mostly-clear (cl 0-1) or extreme (cl 2-3)
            function tStorm() {
                return cl <= 1 ? (isDay ? thunderstormsMostlyClearDay : thunderstormsMostlyClearNight) : (isDay ? thunderstormsExtremeDay : thunderstormsExtremeNight);
            }
            function tStormRain() {
                return cl <= 1 ? (isDay ? thunderstormsMostlyClearDayRain : thunderstormsMostlyClearNightRain) : (isDay ? thunderstormsExtremeDayRain : thunderstormsExtremeNightRain);
            }
            function tStormDrizzle() {
                return cl <= 1 ? (isDay ? thunderstormsMostlyClearDayDrizzle : thunderstormsMostlyClearNightDrizzle) : (isDay ? thunderstormsExtremeDayDrizzle : thunderstormsExtremeNightDrizzle);
            }
            function tStormSnow() {
                return cl <= 1 ? (isDay ? thunderstormsMostlyClearDaySnow : thunderstormsMostlyClearNightSnow) : (isDay ? thunderstormsExtremeDaySnow : thunderstormsExtremeNightSnow);
            }

            // 0-3: Pure sky state — cloud cover determines the icon
            if (code <= 3)
                return skyIcon();
            // 4: Smoke (visibility reduced by smoke)
            if (code === 4)
                return pSmoke();
            // 5: Haze
            if (code === 5)
                return isDay ? hazeDay : hazeNight;
            // 6-9: Dust in suspension / raised by wind / whirls / duststorm in sight
            if (code <= 9)
                return isDay ? dustDay : dustNight;
            // 10: Mist (use fog icons — closest available)
            if (code === 10)
                return isDay ? fogDay : fogNight;
            // 11-12: Shallow fog (patches or continuous)
            if (code <= 12)
                return isDay ? fogDay : fogNight;
            // 13: Lightning visible, no thunder
            if (code === 13)
                return tStorm();
            // 14-16: Precipitation in sight (not reaching / distant / near station)
            if (code <= 16)
                return pDrizzle();
            // 17: Thunderstorm, no precipitation
            if (code === 17)
                return tStorm();
            // 18: Squalls
            if (code === 18)
                return dustWind;
            // 19: Funnel cloud / tornado
            if (code === 19)
                return tornado;

            // 20-29: Recent weather — sky may be clearing, cl drives precip background
            if (code === 20)
                return pDrizzle(); // Recent drizzle or snow grains
            if (code === 21)
                return pRain();    // Recent rain
            if (code === 22)
                return pSnow();    // Recent snow
            if (code <= 24)
                return pSleet();   // Recent rain+snow / freezing drizzle or rain
            if (code === 25)
                return pRain();    // Recent rain showers
            if (code === 26)
                return pSnow();    // Recent snow or rain+snow showers
            if (code === 27)
                return pHail();    // Recent hail showers
            if (code === 28)
                return pFog();     // Recent fog or ice fog
            if (code === 29)
                return tStorm();   // Recent thunderstorm

            // 30-35: Duststorm / sandstorm (slight → severe, decreasing → increasing)
            if (code <= 35)
                return isDay ? dustDay : dustNight;
            // 36-39: Drifting and blowing snow (low / high, slight → heavy)
            if (code <= 39)
                return pSnow();
            // 40-49: Fog and ice fog variants (distance, patches, sky visible/invisible, rime)
            if (code <= 49)
                return isDay ? fogDay : fogNight;
            // 50-55: Drizzle, not freezing (intermittent / continuous, slight → heavy)
            if (code <= 55)
                return pDrizzle();
            // 56-57: Freezing drizzle (slight / moderate or heavy)
            if (code <= 57)
                return pSleet();
            // 58: Drizzle and rain, slight
            if (code === 58)
                return pDrizzle();
            // 59: Drizzle and rain, moderate or heavy
            if (code === 59)
                return pRain();
            // 60-65: Rain, not freezing (intermittent / continuous, slight → heavy)
            if (code <= 65)
                return pRain();
            // 66-67: Freezing rain (slight / moderate or heavy)
            if (code <= 67)
                return pSleet();
            // 68-69: Rain or drizzle and snow (slight / moderate or heavy)
            if (code <= 69)
                return pSleet();
            // 70-78: Snow (intermittent / continuous, slight → heavy; diamond dust; snow grains; ice crystals)
            if (code <= 78)
                return pSnow();
            // 79: Ice pellets
            if (code === 79)
                return pSleet();

            // 80-90: Showers — cl naturally selects mostly-clear / partly-cloudy / extreme background
            if (code <= 82)
                return pRain();   // 80-82: Rain showers (slight / moderate / violent)
            if (code <= 84)
                return pSleet();  // 83-84: Rain and snow showers
            if (code <= 86)
                return pSnow();   // 85-86: Snow showers
            if (code === 87)
                return pSleet();  // Snow pellet shower, slight
            if (code <= 90)
                return pHail();   // 88-90: Snow pellets moderate/heavy, hail showers

            // 91-92: Rain at observation time, thunderstorm during past hour
            if (code <= 92)
                return pRain();
            // 93-94: Snow or hail at observation time, thunderstorm during past hour
            if (code <= 94)
                return pSnow();
            // 95: Thunderstorm slight/moderate with rain or snow
            if (code === 95)
                return tStormRain();
            // 96: Thunderstorm with hail (no hail variant — use rain)
            if (code === 96)
                return tStormRain();
            // 97: Thunderstorm heavy with rain or snow
            if (code === 97)
                return tStormRain();
            // 98: Thunderstorm combined with duststorm or sandstorm
            if (code === 98)
                return tStorm();
            // 99: Thunderstorm heavy with hail (no hail variant — use rain)
            if (code === 99)
                return tStormRain();

            return skyIcon();
        }
    }

    readonly property var shaders: QtObject {
        readonly property url waves: assets.resolveAsset("../shaders/waves.frag.qsb")
    }
}
