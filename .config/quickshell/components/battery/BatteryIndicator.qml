pragma ComponentBehavior: Bound

import QtQuick
import qs

Text {
    property real value: 0
    property color textColor: "white"

    text: `${Math.round(value * 100)}%`
    font.pointSize: Style.font.size2
    font.family: Style.font.family2
    color: textColor
}
