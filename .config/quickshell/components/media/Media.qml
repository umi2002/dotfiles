import Quickshell.Widgets
import QtQuick.Layouts

import qs.assets
import qs.services

WrapperMouseArea {
    id: root
    readonly property string title: Media.spotifyPlayer?.trackTitle || ""
    readonly property string artist: Media.spotifyPlayer?.trackArtist || ""
    readonly property bool isAvailable: Media.spotifyPlayer !== null

    hoverEnabled: true

    RowLayout {
        MediaText {
            text: root.title || "No song playing"
            visible: root.isAvailable
        }

        IconImage {
            source: Assets.logos.spotify
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            implicitSize: 30
        }

        MediaText {
            text: root.artist || ""
            visible: root.isAvailable
        }

        MediaText {
            text: "Spotify unavailable"
            visible: !root.isAvailable
        }
    }
}
