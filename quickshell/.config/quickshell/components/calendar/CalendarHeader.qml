pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs

RowLayout {
    id: root

    required property var viewDate

    signal previousMonth
    signal nextMonth

    function monthName(month) {
        return ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][month];
    }

    Text {
        text: "\u2039"
        color: Style.palette.color1
        font.family: Style.font.family1
        font.pixelSize: Style.font.size1 + 6
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.previousMonth()
        }
    }

    Item {
        Layout.fillWidth: true
    }

    Text {
        text: root.monthName(root.viewDate.getMonth()) + "  " + root.viewDate.getFullYear()
        color: Style.palette.color1
        font.family: Style.font.family3
        font.pixelSize: Style.font.size1
        font.bold: true
    }

    Item {
        Layout.fillWidth: true
    }

    Text {
        text: "\u203a"
        color: Style.palette.color1
        font.family: Style.font.family1
        font.pixelSize: Style.font.size1 + 6
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.nextMonth()
        }
    }
}
