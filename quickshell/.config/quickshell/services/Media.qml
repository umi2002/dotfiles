pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    readonly property list<MprisPlayer> players: Mpris.players.values
    readonly property MprisPlayer spotifyPlayer: players?.find(player => {
        return player.identity === "Spotify";
    }) || null
}
