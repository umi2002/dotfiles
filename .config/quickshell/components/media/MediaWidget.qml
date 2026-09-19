pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick.Layouts

import qs
import qs.services

WrapperMouseArea {
    id: root
    readonly property string title: Media.activePlayer?.trackTitle || ""
    readonly property string artist: Media.activePlayer?.trackArtist || ""
    readonly property bool isAvailable: Media.activePlayer !== null

    hoverEnabled: true

    RowLayout {
        MediaText {
            text: root.title || "No song playing"
            visible: root.isAvailable
        }

        IconImage {
            source: Media.icon
            visible: root.isAvailable && Media.icon != ""
            Layout.leftMargin: Style.spacing.small
            Layout.rightMargin: Style.spacing.small
            implicitSize: 30
        }

        MediaText {
            text: root.artist || ""
            visible: root.isAvailable
        }

        MediaText {
            text: "No media playing"
            visible: !root.isAvailable
        }
    }
}
