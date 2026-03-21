import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.components
import qs.services

RowLayout {
    ColorizedIcon {
        iconSource: Assets.keyboard
        iconColor: Style.palette.text
        implicitSize: 30
    }

    Text {
        text: HyprlandData.keyboardLanguage
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Style.palette.text
        font.family: Style.font.family2
        font.pointSize: Style.font.size2
    }
}
