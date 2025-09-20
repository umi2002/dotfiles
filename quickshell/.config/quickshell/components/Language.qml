import QtQuick

import qs.services

import "../Style.js" as Style

Text {
    text: HyprlandData.keyboardLanguage
    width: implicitWidth
    height: implicitHeight
    color: Style.palette.color1
    font.family: Style.font.family
    font.pointSize: Style.font.size2
}
