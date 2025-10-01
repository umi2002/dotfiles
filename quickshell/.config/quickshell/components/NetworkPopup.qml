import QtQuick
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

ColumnLayout {
    Repeater {
        model: Network.networks

        delegate: Text {
            required property var modelData
            text: modelData.ssid
            font.pointSize: Style.font.size2
            font.family: Style.font.family
            color: Style.palette.color1
        }
    }
}
