import QtQuick
import QtQuick.Layouts
import Caelestia.Services

import qs.services

MediaSection {
    implicitHeight: 100

    ServiceRef {
        service: Audio.cava
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 2

        Repeater {
            model: Array.from({
                length: Audio.cavaBars
            }, (_, i) => i)

            delegate: AudioBar {
                required property double modelData

                Layout.fillWidth: true
                Layout.fillHeight: true
                barValue: Math.max(1e-3, Math.min(1, Audio.cava.values[modelData]))
            }
        }
    }
}
