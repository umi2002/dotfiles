import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Controls

import qs
import qs.services

Rectangle {
    id: root
    implicitHeight: 50

    Slider {
        id: slider

        anchors.centerIn: parent
        enabled: false
        from: 0
        to: Media.spotifyPlayer?.length || 0

        background: Rectangle {
            implicitWidth: root.implicitWidth - 50
            implicitHeight: 10
            radius: implicitHeight / 2
            color: Style.palette.border1

            Rectangle {
                implicitWidth: slider.visualPosition * parent.implicitWidth
                implicitHeight: parent.implicitHeight
                radius: implicitHeight / 2
                color: Style.palette.color1
            }
        }

        handle: Item {}
    }

    FrameAnimation {
        running: Media.spotifyPlayer?.playbackState === MprisPlaybackState.Playing
        onTriggered: {
            slider.value = Media.spotifyPlayer?.position || 0;
        }
    }
}
