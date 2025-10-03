pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import QtQuick

Singleton {
    id: root
    readonly property list<MprisPlayer> players: Mpris.players.values
    readonly property MprisPlayer spotifyPlayer: players?.find(player => {
        return player.identity === "Spotify";
    }) || null
    readonly property string title: spotifyPlayer?.trackTitle || ""
    readonly property string artist: spotifyPlayer?.trackArtist || ""
    readonly property string album: spotifyPlayer?.trackAlbum || ""
    readonly property string art: spotifyPlayer?.trackArtUrl || ""

    function setVolume(volume) {
        setVolumeProcess.volume = volume;
        setVolumeProcess.running = true;
    }

    Process {
        id: setVolumeProcess
        property real volume
        command: ["playerctl", "-p", "spotify", "volume", volume.toString()]
    }
}
