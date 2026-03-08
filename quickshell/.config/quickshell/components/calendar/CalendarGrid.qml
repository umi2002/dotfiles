pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs

ColumnLayout {
    id: root

    required property var viewDate
    required property var selectedDate

    readonly property int cellWidth: 50
    readonly property int cellHeight: 40

    signal daySelected(var date)

    spacing: 0

    Row {
        spacing: 0
        Repeater {
            model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
            Text {
                required property string modelData
                width: root.cellWidth
                text: modelData
                color: Style.palette.color1
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
