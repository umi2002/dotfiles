pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property list<MprisPlayer> players: Mpris.players.values
    readonly property MprisPlayer activePlayer: players.find(player => player.isPlaying) ?? players[0] ?? null

    readonly property string title: activePlayer?.trackTitle ?? ""
    readonly property string artist: activePlayer?.trackArtist ?? ""
    readonly property string album: activePlayer?.trackAlbum ?? ""
    readonly property string art: activePlayer?.trackArtUrl ?? ""
    readonly property string identity: activePlayer?.identity ?? ""
    readonly property url icon: {
        const entry = activePlayer?.desktopEntry ? DesktopEntries.heuristicLookup(activePlayer.desktopEntry) : null;
        return entry?.icon ? Quickshell.iconPath(entry.icon) : "";
    }

    function setVolume(volume) {
        const clampedVolume = Math.max(0, Math.min(1, volume));

        if (root.activePlayer)
            root.activePlayer.volume = clampedVolume;
    }
}
