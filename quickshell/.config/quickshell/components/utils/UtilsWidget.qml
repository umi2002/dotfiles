import QtQuick
import QtQuick.Layouts

import qs
import qs.components

RowLayout {
    id: root

    required property string iconSource
    required property int percentage
    property color iconColor: Style.palette.color1
    property int iconSize: 30
    property int textWidth: 40

    ColorizedIcon {
        iconSource: root.iconSource
        iconColor: root.iconColor
        implicitSize: root.iconSize
    }

    Text {
        text: root.percentage + "%"
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
        Layout.preferredWidth: root.textWidth
        color: Style.palette.color1
        font.family: Style.font.family2
        font.pixelSize: Style.font.size1
    }
}
