import QtQuick.Layouts

import qs.assets
import qs.services

Section {
    id: root

    RowLayout {
        id: layout
        readonly property int iconSize: height - 20

        anchors.fill: parent

        MediaControlButton {
            Layout.alignment: Qt.AlignHCenter
            controlType: "previous"
            iconSource: Assets.media.skipPrevious
            iconSize: layout.iconSize
        }

        MediaControlButton {
            Layout.alignment: Qt.AlignHCenter
            controlType: "play"
            iconSource: Media.spotifyPlayer?.isPlaying ? Assets.media.pause : Assets.media.play
            iconSize: layout.iconSize
        }

        MediaControlButton {
            Layout.alignment: Qt.AlignHCenter
            controlType: "next"
            iconSource: Assets.media.skipNext
            iconSize: layout.iconSize
        }
    }
}
