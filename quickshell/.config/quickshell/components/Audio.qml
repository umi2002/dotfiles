import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts

import "../Style.js" as Style
import qs.services

RowLayout {
    IconImage {
        source: Qt.resolvedUrl(Audio.volumeIcon)
        implicitSize: 30

        layer.enabled: true
        layer.effect: MultiEffect {
            colorization: 1
            colorizationColor: Style.palette.color1
        }
    }

    Text {
        text: Audio.volume + "%"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        Layout.preferredWidth: 40
        color: Style.palette.color1
        font.family: Style.font.family
        font.pixelSize: Style.font.size1
    }
}
