pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.components.dashboard

DashboardSection {
    id: root

    required property var viewDate
    required property var selectedDate

    readonly property int cellWidth: 50
    readonly property int cellHeight: 40

    signal daySelected(var date)

    implicitWidth: cellWidth * 7 + 20
    implicitHeight: grid.implicitHeight + 20

    ColumnLayout {
        id: grid
        anchors.centerIn: parent
        spacing: 0

        Row {
            spacing: 0
            Repeater {
                model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
                Text {
                    required property string modelData
                    width: root.cellWidth
                    text: modelData
                    color: Style.palette.crust
                    font.family: Style.font.family3
                    font.pixelSize: Style.font.size2
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

        Grid {
            columns: 7
            spacing: 0

            Repeater {
                model: parent.columns * 5
                delegate: CalendarDayCell {
                    required property int index
                    cellIndex: index
                    viewDate: root.viewDate
                    selectedDate: root.selectedDate
                    width: root.cellWidth
                    height: root.cellHeight
                    onClicked: date => root.daySelected(date)
                }
            }
        }
    }
}
