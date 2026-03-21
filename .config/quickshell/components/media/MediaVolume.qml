import qs.components
import qs.services

MediaSection {
    id: root
    implicitWidth: 50

    VerticalSlider {
        sliderWidth: 10
        sliderHeight: root.height - 50
        anchors.centerIn: parent
        value: Media.spotifyPlayer?.volume || 0
        from: 0
        to: 1

        onValueChange: function (newValue) {
            Media.setVolume(newValue);
        }
    }
}
