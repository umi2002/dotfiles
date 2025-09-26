import Quickshell.Widgets

import QtQuick
import QtQuick.Layouts

import qs.services

import "../Style.js" as Style

RowLayout {
    id: root

    readonly property string title: Media.spotifyPlayer?.trackTitle || ""
    readonly property string artist: Media.spotifyPlayer?.trackArtist || ""

    Text {
        text: root.title || ""
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Style.palette.color1
        font.family: Style.font.family
        font.pointSize: Style.font.size1
        visible: Media.spotifyPlayer
    }

    IconImage {
        source: Qt.resolvedUrl("../assets/spotify_logo.svg")
        Layout.leftMargin: 5
        Layout.rightMargin: 5
        implicitSize: 30
    }

    Text {
        text: root.artist || ""
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Style.palette.color1
        font.family: Style.font.family
        font.pointSize: Style.font.size1
        visible: Media.spotifyPlayer
    }

    Text {
        text: "Spotify unavailable"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Style.palette.color1
        font.family: Style.font.family
        font.pointSize: Style.font.size1
        visible: !Media.spotifyPlayer
    }
}
