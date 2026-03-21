import Quickshell.Widgets

import qs.services

WrapperMouseArea {
    id: root

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
        Audio.toggleMute();
    }

    UtilsWidget {
        iconSource: Audio.volumeIcon
        percentage: Audio.volume
    }
}
