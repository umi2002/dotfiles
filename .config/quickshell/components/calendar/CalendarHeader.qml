pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.components.dashboard

DashboardSection {
    id: root

    required property var viewDate

    signal previousMonth
    signal nextMonth

    implicitHeight: header.implicitHeight + 30

    function monthName(month) {
        return ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"][month];
    }

    RowLayout {
        id: header
        anchors.centerIn: parent

        Text {
            text: "\u2039"
            color: Style.palette.subtext1
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
            implicitWidth: 40
        }

        Text {
            text: root.monthName(root.viewDate.getMonth()) + "  " + root.viewDate.getFullYear()
            color: Style.palette.text
            font.family: Style.font.family3
            font.pixelSize: Style.font.size1
            font.bold: true
        }

        Item {
            Layout.fillWidth: true
            implicitWidth: 40
        }

        Text {
            text: "\u203a"
            color: Style.palette.subtext1
            font.family: Style.font.family1
            font.pixelSize: Style.font.size1 + 6
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: root.nextMonth()
            }
        }
    }
}
