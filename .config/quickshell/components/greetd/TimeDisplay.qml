import QtQuick
import QtQuick.Layouts

import qs

ColumnLayout {
    Text {
        id: timeLabel
        text: Qt.formatTime(new Date(), "hh:mm")
        font.family: Style.font.family4
        font.pointSize: 64
        color: Style.palette.text
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignRight

        Timer {
            interval: 1000
            repeat: true
            running: true
            onTriggered: timeLabel.text = Qt.formatTime(new Date(), "hh:mm")
        }
    }

    Text {
        text: Qt.formatDate(new Date(), "dddd, MMMM dd yyyy")
        font.family: Style.font.family4
        font.pointSize: Style.font.size1
        color: Style.palette.subtext1
        Layout.fillWidth: true
        horizontalAlignment: Text.AlignRight
    }
}
