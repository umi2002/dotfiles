import Quickshell.Widgets

import qs
import qs.components
import qs.services

WrapperMouseArea {
    id: root
    required property string iconSource
    required property string iconSize
    property string controlType: "play"
    property var player: Media.spotifyPlayer

    cursorShape: Qt.PointingHandCursor

    onClicked: {
        if (!player)
            return;

        switch (controlType) {
        case "previous":
            player.previous();
            break;
        case "play":
            player.togglePlaying();
            break;
        case "next":
            player.next();
            break;
        }
    }

    child: ColorizedIcon {
        id: icon
        anchors.centerIn: parent
        iconSource: root.iconSource
        iconColor: Style.palette.color1
        implicitSize: root.iconSize
    }
}
