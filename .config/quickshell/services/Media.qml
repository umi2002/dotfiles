pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property list<MprisPlayer> players: Mpris.players.values

    readonly property MprisPlayer spotifyPlayer: {
        for (let i = 0; i < players.length; i++) {
            if (players[i].identity === "Spotify") {
                return players[i];
            }
        }
        return null;
    }

    readonly property string title: spotifyPlayer?.trackTitle ?? ""
    readonly property string artist: spotifyPlayer?.trackArtist ?? ""
    readonly property string album: spotifyPlayer?.trackAlbum ?? ""
    readonly property string art: spotifyPlayer?.trackArtUrl ?? ""

    function setVolume(volume) {
        const clampedVolume = Math.max(0, Math.min(1, volume));

        if (root.spotifyPlayer)
            root.spotifyPlayer.volume = clampedVolume;
    }
}
