import Quickshell.Services.Mpris
import QtQuick

import qs.services
import qs.components

MediaSection {
    id: root
    property var player: Media.spotifyPlayer

    implicitHeight: 50

    HorizontalSlider {
        id: slider
        anchors.centerIn: parent
        sliderWidth: root.implicitWidth - 50
        sliderHeight: 10

        enabled: false
        from: 0
        to: root.player?.length || 0

        FrameAnimation {
            running: root.player?.playbackState === MprisPlaybackState.Playing
            onTriggered: {
                slider.value = root.player?.position || 0;
            }
        }
    }
}
