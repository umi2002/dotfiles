pragma Singleton

import QtQuick

QtObject {
    readonly property var palette: QtObject {
        readonly property color color1: "#C1E0F7"
        readonly property color color2: "#DEBA37"
        readonly property color color3: "#C25F13"
        readonly property color background1: "#071445"
        readonly property color background2: "#010B29"
        readonly property color border1: "#284BC9"
        readonly property color border2: "#03060F"
    }

    readonly property var font: QtObject {
        readonly property string family1: "Cantarell"
        readonly property string family2: "CaskaydiaCove Nerd Font Mono"
        readonly property string family3: "Noto Sans Mono CJK"
        readonly property int size1: 16
        readonly property int size2: 12
    }
}
