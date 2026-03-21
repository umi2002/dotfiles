import QtQuick

import qs

Text {
    id: root
    property alias fontSize: root.font.pointSize
    property alias fontFamily: root.font.family
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: Style.palette.text
    font.family: Style.font.family3
    font.pointSize: Style.font.size1
}
