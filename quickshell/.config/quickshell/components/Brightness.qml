import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.services

RowLayout {
    ColorizedIcon {
        iconSource: Qt.resolvedUrl(Brightness.brightnessIcon)
        iconColor: Style.palette.color1
        implicitSize: 30
    }

    Text {
        text: Brightness.brightnessPercent + "%"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        Layout.preferredWidth: 40
        color: Style.palette.color1
        font.family: Style.font.family2
        font.pixelSize: Style.font.size1
    }
}
