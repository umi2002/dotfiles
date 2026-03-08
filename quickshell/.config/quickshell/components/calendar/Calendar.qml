import Quickshell.Widgets
import QtQuick

import qs
import qs.services

WrapperMouseArea {
    hoverEnabled: true

    Text {
        color: Style.palette.color2
        font.family: Style.font.family2
        font.pointSize: Style.font.size2

        text: Calendar.time
    }
}
