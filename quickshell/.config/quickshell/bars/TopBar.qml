import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.components
import qs.components.workspaces
import qs.components.calendar

Rectangle {
    id: root
    readonly property bool hasPopup: calendarPopup.isExpanded
    readonly property int margins: 10

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    Item {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height

        RowLayout {
            spacing: 20

            IconImage {
                source: Assets.archLinux

                implicitSize: 30
                Layout.alignment: Qt.AlignVCenter
            }

            Workspaces {
                Layout.alignment: Qt.AlignVCenter
                radius: Math.min(width, height) / 2
            }
        }
    }

    Title {
        anchors.centerIn: parent
        color: Style.palette.color1
        font.family: Style.font.family1
        font.pointSize: Style.font.size1
    }

    Rectangle {
        id: calendarPopupContainer
        anchors.right: calendar.right
        anchors.top: calendar.bottom
        anchors.rightMargin: 10
        width: calendarPopup.implicitWidth
        height: calendarPopup.implicitHeight + 20
        color: "transparent"

        MouseArea {
            id: calendarPopupMouseArea
            enabled: calendarPopup.implicitHeight > 0
            anchors.fill: parent
            hoverEnabled: true

            StyledPopup {
                id: calendarPopup
                isExpanded: calendarPopupMouseArea.containsMouse || calendar.containsMouse
                anchors.bottom: calendarPopupMouseArea.bottom
                popupContent: CalendarPopup {}
            }
        }
    }

    Calendar {
        id: calendar
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
}
