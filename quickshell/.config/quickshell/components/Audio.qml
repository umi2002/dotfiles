import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

WrapperMouseArea {
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
        Audio.toggleMute();
    }

    RowLayout {
        ColorizedIcon {
            iconSource: Audio.volumeIcon
            iconColor: Style.palette.color1
            implicitSize: 30
        }

        Text {
            text: Audio.volume + "%"
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.preferredWidth: 40
            color: Style.palette.color1
            font.family: Style.font.family2
            font.pixelSize: Style.font.size1
        }
    }
}
