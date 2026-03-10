pragma Singleton

import Quickshell
import Quickshell.Io
import QtQml

import qs.assets

Singleton {
    id: root

    readonly property string station: "Montreal-Trudeau"
    property real temperature: NaN
    property real humidity: NaN
    property string lastUpdated: ""
    property int weatherCode: -1
    property int cloudCover: -1
    property bool isDay: false
    readonly property url icon: getIcon()

    function getIcon(): url {
        const wc = root.weatherCode;
        const day = root.isDay;
        const cc = root.cloudCover;

        if (wc < 0 || wc <= 3) {
            // No significant weather — pick by cloud cover (oktas 0-8)
            if (cc <= 0)
                return day ? Assets.weather.clearDay : Assets.weather.clearNight;
            if (cc <= 2)
                return day ? Assets.weather.mostlyClearDay : Assets.weather.mostlyClearNight;
            if (cc <= 4)
                return day ? Assets.weather.partlyCloudyDay : Assets.weather.partlyCloudyNight;
            if (cc <= 6)
                return day ? Assets.weather.mostlyCloudyDay : Assets.weather.mostlyCloudyNight;
            return Assets.weather.cloudy;
        }
        if (wc <= 9)
            return Assets.weather.hazeFogDustSmoke;              // Smoke, haze, dust, sand
        if (wc <= 12)
            return Assets.weather.hazeFogDustSmoke;              // Mist, shallow fog
        if (wc === 13 || wc === 17)
            return Assets.weather.isolatedThunderstorms; // Lightning / thunderstorm, no precip
        if (wc === 18)
            return Assets.weather.windy;                         // Squall
        if (wc === 19)
            return Assets.weather.tornado;                       // Tornado / funnel cloud
        if (wc === 20)
            return Assets.weather.drizzle;                       // Drizzle or snow grains (past hour)
        if (wc === 21)
            return Assets.weather.showersRain;                   // Rain (past hour)
        if (wc === 22)
            return Assets.weather.showersSnow;                   // Snow (past hour)
        if (wc === 23)
            return Assets.weather.mixedRainSnow;                 // Rain and snow (past hour)
        if (wc === 24)
            return Assets.weather.icy;                           // Freezing drizzle or rain (past hour)
        if (wc === 25)
            return day ? Assets.weather.scatteredShowersDay : Assets.weather.scatteredShowersNight;
        if (wc === 26)
            return day ? Assets.weather.scatteredSnowShowersDay : Assets.weather.scatteredSnowShowersNight;
        if (wc === 27)
            return Assets.weather.mixedRainHailSleet;            // Hail shower (past hour)
        if (wc === 28)
            return Assets.weather.hazeFogDustSmoke;              // Fog or ice fog (past hour)
        if (wc === 29)
            return day ? Assets.weather.isolatedScatteredThunderstormsDay : Assets.weather.isolatedScatteredThunderstormsNight;
        if (wc <= 35)
            return Assets.weather.hazeFogDustSmoke;              // Duststorm / sandstorm
        if (wc <= 39)
            return Assets.weather.blowingSnow;                   // Drifting or blowing snow
        if (wc <= 49)
            return Assets.weather.hazeFogDustSmoke;              // Fog / ice fog (various)
        if (wc <= 55)
            return Assets.weather.drizzle;                       // Drizzle (intermittent to continuous)
        if (wc <= 57)
            return Assets.weather.icy;                           // Freezing drizzle
        if (wc <= 59)
            return Assets.weather.drizzle;                       // Drizzle and rain
        if (wc <= 61)
            return Assets.weather.showersRain;                   // Light / intermittent rain
        if (wc <= 65)
            return Assets.weather.heavyRain;                     // Moderate to heavy continuous rain
        if (wc <= 67)
            return Assets.weather.icy;                           // Freezing rain
        if (wc <= 69)
            return Assets.weather.mixedRainSnow;                 // Rain or drizzle and snow
        if (wc <= 73)
            return Assets.weather.showersSnow;                   // Light to moderate snow
        if (wc <= 75)
            return Assets.weather.heavySnow;                     // Heavy snow
        if (wc === 76 || wc === 78)
            return Assets.weather.icy;              // Diamond dust / ice crystals
        if (wc === 77)
            return Assets.weather.flurries;                      // Snow grains
        if (wc === 79)
            return Assets.weather.sleetHail;                     // Ice pellets
        if (wc <= 81)
            return day ? Assets.weather.scatteredShowersDay : Assets.weather.scatteredShowersNight;
        if (wc <= 84)
            return Assets.weather.heavyRain;                     // Heavy rain showers
        if (wc <= 86)
            return day ? Assets.weather.scatteredSnowShowersDay : Assets.weather.scatteredSnowShowersNight;
        if (wc <= 88)
            return Assets.weather.mixedRainSnow;                 // Mixed rain and snow showers
        if (wc <= 90)
            return Assets.weather.mixedRainHailSleet;            // Hail showers
        if (wc <= 92)
            return day ? Assets.weather.isolatedScatteredThunderstormsDay : Assets.weather.isolatedScatteredThunderstormsNight;
        if (wc <= 94)
            return Assets.weather.strongThunderstorms;           // Thunderstorm with snow or hail
        if (wc === 95)
            return Assets.weather.isolatedThunderstorms;         // Slight or moderate thunderstorm
        return Assets.weather.strongThunderstorms;                          // Heavy thunderstorm / with hail (96-99)
    }

    function parseValue(xml, name) {
        const rx = new RegExp('name="' + name + '"[^>]*value="([^"]*)"');
        const m = xml.match(rx);
        return m ? parseFloat(m[1]) : NaN;
    }

    function parseWeather(xml) {
        root.temperature = parseValue(xml, "air_temp");
        root.humidity = parseValue(xml, "rel_hum");

        const t = xml.match(/valid-time="([^"]+)"/);
        if (t) {
            root.lastUpdated = t[1];
        }

        const codeMatch = xml.match(/name="present_weather"[^>]*value="(\d+)"/);
        root.weatherCode = codeMatch ? parseInt(codeMatch[1]) : -1;

        const cloudMatch = xml.match(/name="tot_cloud_cover"[^>]*value="(\d+)"/);
        root.cloudCover = cloudMatch ? parseInt(cloudMatch[1]) : -1;

        const h = new Date().getHours();
        root.isDay = h >= 6 && h < 20;
    }

    Process {
        id: fetchProcess
        command: ["curl", "-s", "https://dd.weather.gc.ca/today/observations/swob-ml/latest/CYUL-MAN-swob.xml"]
        stdout: StdioCollector {
            onStreamFinished: root.parseWeather(this.text)
        }
    }

    Timer {
        interval: 10 * 60 * 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: fetchProcess.running = true
    }
}
