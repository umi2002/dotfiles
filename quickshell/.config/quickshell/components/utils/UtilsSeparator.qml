import QtQuick
import QtQuick.Layouts

import qs

Rectangle {
    readonly property int margin: 5
    Layout.alignment: Qt.AlignHCenter
    Layout.preferredWidth: 2
    Layout.fillHeight: true
    Layout.leftMargin: margin
    Layout.rightMargin: margin
    color: Style.palette.color1
    opacity: 0.4
}
