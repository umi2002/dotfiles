pragma Singleton
import QtQuick

QtObject {
    id: assets

    function resolveAsset(filename: string): url {
        return Qt.resolvedUrl(filename);
    }

    readonly property url archLinux: resolveAsset("arch_linux_icon.svg")
    readonly property url caretForward: assets.resolveAsset("caret_forward_icon.svg")
    readonly property url dashboardVideo: assets.resolveAsset("calamitas.mp4")

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

    readonly property var stats: QtObject {
        readonly property url basePath: "stats_icons/"
        readonly property url os: assets.resolveAsset("arch_linux_icon.svg")
        readonly property url kernel: assets.resolveAsset(basePath + "linux.svg")
        readonly property url uptime: assets.resolveAsset(basePath + "clock.svg")
        readonly property url wm: assets.resolveAsset(basePath + "wm.svg")
        readonly property url cpu: assets.resolveAsset(basePath + "cpu.svg")
        readonly property url gpu: assets.resolveAsset(basePath + "gpu.svg")
        readonly property url memory: assets.resolveAsset(basePath + "memory.svg")
        readonly property url storage: assets.resolveAsset(basePath + "storage.svg")
    }

    readonly property var battery: QtObject {
        readonly property string basePath: "battery_icons/"

        readonly property url action: assets.resolveAsset(basePath + "battery-action-symbolic.svg")
        readonly property url caution: assets.resolveAsset(basePath + "battery-caution-symbolic.svg")
        readonly property url low: assets.resolveAsset(basePath + "battery-low-symbolic.svg")
        readonly property url missing: assets.resolveAsset(basePath + "battery-missing-symbolic.svg")
        readonly property url power_saver: assets.resolveAsset(basePath + "power_saver.svg")
        readonly property url performance: assets.resolveAsset(basePath + "performance.svg")
        readonly property url balanced: assets.resolveAsset(basePath + "balanced.svg")

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

        readonly property url blizzard: assets.resolveAsset(basePath + "blizzard.svg")
        readonly property url blowingSnow: assets.resolveAsset(basePath + "blowing_snow.svg")
        readonly property url clearDay: assets.resolveAsset(basePath + "clear_day.svg")
        readonly property url clearNight: assets.resolveAsset(basePath + "clear_night.svg")
        readonly property url cloudy: assets.resolveAsset(basePath + "cloudy.svg")
        readonly property url cloudyWithRainDark: assets.resolveAsset(basePath + "cloudy_with_rain_dark.svg")
        readonly property url cloudyWithRainLight: assets.resolveAsset(basePath + "cloudy_with_rain_light.svg")
        readonly property url cloudyWithSnowDark: assets.resolveAsset(basePath + "cloudy_with_snow_dark.svg")
        readonly property url cloudyWithSnowLight: assets.resolveAsset(basePath + "cloudy_with_snow_light.svg")
        readonly property url cloudyWithSunnyDark: assets.resolveAsset(basePath + "cloudy_with_sunny_dark.svg")
        readonly property url cloudyWithSunnyLight: assets.resolveAsset(basePath + "cloudy_with_sunny_light.svg")
        readonly property url drizzle: assets.resolveAsset(basePath + "drizzle.svg")
        readonly property url flurries: assets.resolveAsset(basePath + "flurries.svg")
        readonly property url hazeFogDustSmoke: assets.resolveAsset(basePath + "haze_fog_dust_smoke.svg")
        readonly property url heavyRain: assets.resolveAsset(basePath + "heavy_rain.svg")
        readonly property url heavySnow: assets.resolveAsset(basePath + "heavy_snow.svg")
        readonly property url icy: assets.resolveAsset(basePath + "icy.svg")
        readonly property url isolatedScatteredThunderstormsDay: assets.resolveAsset(basePath + "isolated_scattered_thunderstorms_day.svg")
        readonly property url isolatedScatteredThunderstormsNight: assets.resolveAsset(basePath + "isolated_scattered_thunderstorms_night.svg")
        readonly property url isolatedThunderstorms: assets.resolveAsset(basePath + "isolated_thunderstorms.svg")
        readonly property url mixedRainHailSleet: assets.resolveAsset(basePath + "mixed_rain_hail_sleet.svg")
        readonly property url mixedRainSnow: assets.resolveAsset(basePath + "mixed_rain_snow.svg")
        readonly property url mostlyClearDay: assets.resolveAsset(basePath + "mostly_clear_day.svg")
        readonly property url mostlyClearNight: assets.resolveAsset(basePath + "mostly_clear_night.svg")
        readonly property url mostlyCloudyDay: assets.resolveAsset(basePath + "mostly_cloudy_day.svg")
        readonly property url mostlyCloudyNight: assets.resolveAsset(basePath + "mostly_cloudy_night.svg")
        readonly property url partlyCloudyDay: assets.resolveAsset(basePath + "partly_cloudy_day.svg")
        readonly property url partlyCloudyNight: assets.resolveAsset(basePath + "partly_cloudy_night.svg")
        readonly property url rainWithCloudyDark: assets.resolveAsset(basePath + "rain_with_cloudy_dark.svg")
        readonly property url rainWithCloudyLight: assets.resolveAsset(basePath + "rain_with_cloudy_light.svg")
        readonly property url rainWithSnowDark: assets.resolveAsset(basePath + "rain_with_snow_dark.svg")
        readonly property url rainWithSnowLight: assets.resolveAsset(basePath + "rain_with_snow_light.svg")
        readonly property url rainWithSunnyDark: assets.resolveAsset(basePath + "rain_with_sunny_dark.svg")
        readonly property url rainWithSunnyLight: assets.resolveAsset(basePath + "rain_with_sunny_light.svg")
        readonly property url scatteredShowersDay: assets.resolveAsset(basePath + "scattered_showers_day.svg")
        readonly property url scatteredShowersNight: assets.resolveAsset(basePath + "scattered_showers_night.svg")
        readonly property url scatteredSnowShowersDay: assets.resolveAsset(basePath + "scattered_snow_showers_day.svg")
        readonly property url scatteredSnowShowersNight: assets.resolveAsset(basePath + "scattered_snow_showers_night.svg")
        readonly property url showersRain: assets.resolveAsset(basePath + "showers_rain.svg")
        readonly property url showersSnow: assets.resolveAsset(basePath + "showers_snow.svg")
        readonly property url sleetHail: assets.resolveAsset(basePath + "sleet_hail.svg")
        readonly property url snowWithCloudyDark: assets.resolveAsset(basePath + "snow_with_cloudy_dark.svg")
        readonly property url snowWithCloudyLight: assets.resolveAsset(basePath + "snow_with_cloudy_light.svg")
        readonly property url snowWithRainDark: assets.resolveAsset(basePath + "snow_with_rain_dark.svg")
        readonly property url snowWithRainLight: assets.resolveAsset(basePath + "snow_with_rain_light.svg")
        readonly property url snowWithSunnyDark: assets.resolveAsset(basePath + "snow_with_sunny_dark.svg")
        readonly property url snowWithSunnyLight: assets.resolveAsset(basePath + "snow_with_sunny_light.svg")
        readonly property url strongThunderstorms: assets.resolveAsset(basePath + "strong_thunderstorms.svg")
        readonly property url sunnyWithCloudyDark: assets.resolveAsset(basePath + "sunny_with_cloudy_dark.svg")
        readonly property url sunnyWithCloudyLight: assets.resolveAsset(basePath + "sunny_with_cloudy_light.svg")
        readonly property url sunnyWithRainDark: assets.resolveAsset(basePath + "sunny_with_rain_dark.svg")
        readonly property url sunnyWithRainLight: assets.resolveAsset(basePath + "sunny_with_rain_light.svg")
        readonly property url sunnyWithSnowDark: assets.resolveAsset(basePath + "sunny_with_snow_dark.svg")
        readonly property url sunnyWithSnowLight: assets.resolveAsset(basePath + "sunny_with_snow_light.svg")
        readonly property url tornado: assets.resolveAsset(basePath + "tornado.svg")
        readonly property url tropicalStormHurricane: assets.resolveAsset(basePath + "tropical_storm_hurricane.svg")
        readonly property url umbrella: assets.resolveAsset(basePath + "umbrella.svg")
        readonly property url veryCold: assets.resolveAsset(basePath + "very_cold.svg")
        readonly property url veryHot: assets.resolveAsset(basePath + "very_hot.svg")
        readonly property url windy: assets.resolveAsset(basePath + "windy.svg")

        function getIcon(wc: int, day: bool, cc: int): url {
            if (wc < 0 || wc <= 3) {
                // No significant weather — pick by cloud cover (oktas 0-8)
                if (cc <= 0)
                    return day ? assets.weather.clearDay : assets.weather.clearNight;
                if (cc <= 2)
                    return day ? assets.weather.mostlyClearDay : assets.weather.mostlyClearNight;
                if (cc <= 4)
                    return day ? assets.weather.partlyCloudyDay : assets.weather.partlyCloudyNight;
                if (cc <= 6)
                    return day ? assets.weather.mostlyCloudyDay : assets.weather.mostlyCloudyNight;
                return assets.weather.cloudy;
            }
            if (wc <= 9)
                return assets.weather.hazeFogDustSmoke;              // Smoke, haze, dust, sand
            if (wc <= 12)
                return assets.weather.hazeFogDustSmoke;              // Mist, shallow fog
            if (wc === 13 || wc === 17)
                return assets.weather.isolatedThunderstorms;         // Lightning / thunderstorm, no precip
            if (wc === 18)
                return assets.weather.windy;                         // Squall
            if (wc === 19)
                return assets.weather.tornado;                       // Tornado / funnel cloud
            if (wc === 20)
                return assets.weather.drizzle;                       // Drizzle or snow grains (past hour)
            if (wc === 21)
                return assets.weather.showersRain;                   // Rain (past hour)
            if (wc === 22)
                return assets.weather.showersSnow;                   // Snow (past hour)
            if (wc === 23)
                return assets.weather.mixedRainSnow;                 // Rain and snow (past hour)
            if (wc === 24)
                return assets.weather.icy;                           // Freezing drizzle or rain (past hour)
            if (wc === 25)
                return day ? assets.weather.scatteredShowersDay : assets.weather.scatteredShowersNight;
            if (wc === 26)
                return day ? assets.weather.scatteredSnowShowersDay : assets.weather.scatteredSnowShowersNight;
            if (wc === 27)
                return assets.weather.mixedRainHailSleet;            // Hail shower (past hour)
            if (wc === 28)
                return assets.weather.hazeFogDustSmoke;              // Fog or ice fog (past hour)
            if (wc === 29)
                return day ? assets.weather.isolatedScatteredThunderstormsDay : assets.weather.isolatedScatteredThunderstormsNight;
            if (wc <= 35)
                return assets.weather.hazeFogDustSmoke;              // Duststorm / sandstorm
            if (wc <= 39)
                return assets.weather.blowingSnow;                   // Drifting or blowing snow
            if (wc <= 49)
                return assets.weather.hazeFogDustSmoke;              // Fog / ice fog (various)
            if (wc <= 55)
                return assets.weather.drizzle;                       // Drizzle (intermittent to continuous)
            if (wc <= 57)
                return assets.weather.icy;                           // Freezing drizzle
            if (wc <= 59)
                return assets.weather.drizzle;                       // Drizzle and rain
            if (wc <= 61)
                return assets.weather.showersRain;                   // Light / intermittent rain
            if (wc <= 65)
                return assets.weather.heavyRain;                     // Moderate to heavy continuous rain
            if (wc <= 67)
                return assets.weather.icy;                           // Freezing rain
            if (wc <= 69)
                return assets.weather.mixedRainSnow;                 // Rain or drizzle and snow
            if (wc <= 73)
                return assets.weather.showersSnow;                   // Light to moderate snow
            if (wc <= 75)
                return assets.weather.heavySnow;                     // Heavy snow
            if (wc === 76 || wc === 78)
                return assets.weather.icy;                           // Diamond dust / ice crystals
            if (wc === 77)
                return assets.weather.flurries;                      // Snow grains
            if (wc === 79)
                return assets.weather.sleetHail;                     // Ice pellets
            if (wc <= 81)
                return day ? assets.weather.scatteredShowersDay : assets.weather.scatteredShowersNight;
            if (wc <= 84)
                return assets.weather.heavyRain;                     // Heavy rain showers
            if (wc <= 86)
                return day ? assets.weather.scatteredSnowShowersDay : assets.weather.scatteredSnowShowersNight;
            if (wc <= 88)
                return assets.weather.mixedRainSnow;                 // Mixed rain and snow showers
            if (wc <= 90)
                return assets.weather.mixedRainHailSleet;            // Hail showers
            if (wc <= 92)
                return day ? assets.weather.isolatedScatteredThunderstormsDay : assets.weather.isolatedScatteredThunderstormsNight;
            if (wc <= 94)
                return assets.weather.strongThunderstorms;           // Thunderstorm with snow or hail
            if (wc === 95)
                return assets.weather.isolatedThunderstorms;         // Slight or moderate thunderstorm
            return assets.weather.strongThunderstorms;               // Heavy thunderstorm / with hail (96-99)
        }
    }
}
