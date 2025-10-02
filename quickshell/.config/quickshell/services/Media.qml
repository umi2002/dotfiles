pragma Singleton

import Quickshell
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
    property real position: spotifyPlayer?.position || 0
    property real length: spotifyPlayer?.length || 0

    function updatePositions() {
        position = spotifyPlayer?.position;
        length = spotifyPlayer?.length;
    }

    function setPosition(position) {
        spotifyPlayer?.seek(position - root.position);
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: root.updatePositions()
    }

    Connections {
        target: root.spotifyPlayer
        function onPostTrackChanged() {
            root.updatePositions();
        }
    }
}
