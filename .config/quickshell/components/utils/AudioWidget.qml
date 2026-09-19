pragma ComponentBehavior: Bound

import Quickshell.Widgets

import qs.assets

import qs.services

WrapperMouseArea {
    id: root

    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor

    onClicked: {
        Audio.toggleMute();
    }

    UtilsWidget {
        iconSource: Assets.volume.getIcon(Audio.volume, Audio.muted)
        percentage: Audio.volume
    }
}
