pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick.Layouts

import qs
import qs.services

WrapperMouseArea {
    id: root
    property int maxTextWidth: 250
    readonly property string title: Media.activePlayer?.trackTitle || ""
    readonly property string artist: Media.activePlayer?.trackArtist || ""
    readonly property bool isAvailable: Media.activePlayer !== null

    hoverEnabled: true

    RowLayout {
        ScrollingText {
            text: root.title || "No song playing"
            visible: root.isAvailable
            maximumWidth: root.maxTextWidth
            fontSize: Style.font.size1
            Layout.preferredHeight: implicitHeight
        }

        IconImage {
            source: Media.icon
            visible: root.isAvailable && Media.icon != ""
            Layout.leftMargin: Style.spacing.small
            Layout.rightMargin: Style.spacing.small
            implicitSize: 30
        }

        ScrollingText {
            text: root.artist || ""
            visible: root.isAvailable
            maximumWidth: root.maxTextWidth
            fontSize: Style.font.size1
            Layout.preferredHeight: implicitHeight
        }

        MediaText {
            text: "No media playing"
            visible: !root.isAvailable
        }
    }
}
