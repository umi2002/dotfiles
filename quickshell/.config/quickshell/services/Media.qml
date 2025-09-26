pragma Singleton

import Quickshell
import Quickshell.Services.Mpris
import QtQuick

Singleton {
    readonly property list<MprisPlayer> players: Mpris.players.values
    readonly property MprisPlayer spotifyPlayer: players?.find(player => {
        console.log(JSON.stringify(player));
        return player.identity === "Spotify";
    }) || null
}
