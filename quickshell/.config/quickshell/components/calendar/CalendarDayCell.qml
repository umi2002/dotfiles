pragma ComponentBehavior: Bound

import QtQuick
import Qt5Compat.GraphicalEffects

import qs
import qs.services

Item {
    id: root

    required property int cellIndex
    required property var viewDate
    required property var selectedDate

    signal clicked(var date)

    readonly property int year: viewDate.getFullYear()
    readonly property int month: viewDate.getMonth()
    readonly property int offset: cellIndex - firstWeekday(year, month)
    readonly property var cellDate: new Date(year, month, offset + 1)
    readonly property bool inMonth: offset >= 0 && offset < daysInMonth(year, month)
    readonly property bool isToday: inMonth && isSameDay(cellDate, new Date())
    readonly property bool isSelected: inMonth && isSameDay(cellDate, selectedDate)
    readonly property int eventCount: {
        Calendar.events;
        return inMonth ? Calendar.eventsForDate(cellDate).length : 0;
    }

    function daysInMonth(year, month) {
        return new Date(year, month + 1, 0).getDate();
    }
    function firstWeekday(year, month) {
        return new Date(year, month, 1).getDay();
    }
    function isSameDay(day1, day2) {
        return day2 !== null && day1.getFullYear() === day2.getFullYear() && day1.getMonth() === day2.getMonth() && day1.getDate() === day2.getDate();
    }

    Rectangle {
        id: highlight
        readonly property int size: Math.min(parent.width, parent.height) - 8

        anchors.centerIn: parent
        width: size
        height: size
        radius: size / 2
        color: "transparent"

        Rectangle {
            id: bgMask
            anchors.fill: parent
            radius: parent.radius
            visible: false
        }

        LinearGradient {
            anchors.fill: parent
            source: bgMask
            start: Qt.point(0, 0)
            end: Qt.point(width, height)
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: root.isSelected ? Style.palette.color1 : root.isToday ? Style.palette.border1 : "transparent"
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
                GradientStop {
                    position: 1.0
                    color: root.isSelected ? Style.palette.color1 : root.isToday ? Style.palette.color1 : "transparent"
                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }
                }
            }
        }

        Text {
            id: text

            anchors.centerIn: parent
            text: root.inMonth ? root.cellDate.getDate() : ""
            color: root.isToday || root.isSelected ? Style.palette.background1 : Qt.rgba(Style.palette.color1.r, Style.palette.color1.g, Style.palette.color1.b, root.inMonth ? 0.85 : 0)
            font.family: Style.font.family3
            font.pixelSize: Style.font.size1
            font.bold: root.isToday || root.isSelected
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: text.bottom
            spacing: 2
            Repeater {
                model: Math.min(root.eventCount, 3)
                Rectangle {
                    readonly property int size: 4

                    width: size
                    height: size
                    radius: size / 2
                    color: Style.palette.color2
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: root.inMonth
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked(root.isSelected ? null : root.cellDate)
    }
}
