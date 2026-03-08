pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: root

    property bool isExpanded

    property var viewDate: {
        const date = new Date();
        return new Date(date.getFullYear(), date.getMonth(), 1);
    }
    property var selectedDate: null

    spacing: 5

    CalendarHeader {
        Layout.fillWidth: true
        viewDate: root.viewDate
        onPreviousMonth: {
            const d = root.viewDate;
            root.viewDate = new Date(d.getFullYear(), d.getMonth() - 1, 1);
            root.selectedDate = null;
        }
        onNextMonth: {
            const d = root.viewDate;
            root.viewDate = new Date(d.getFullYear(), d.getMonth() + 1, 1);
            root.selectedDate = null;
        }
    }

    CalendarGrid {
        viewDate: root.viewDate
        selectedDate: root.selectedDate
        onDaySelected: date => root.selectedDate = date
    }

    CalendarEventList {
        Layout.fillWidth: true
        selectedDate: root.selectedDate
    }
}
