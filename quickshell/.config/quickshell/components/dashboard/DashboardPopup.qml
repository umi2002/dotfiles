pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.components.calendar
import qs.components.weather

Rectangle {
    id: root
    property bool isExpanded
    readonly property int spacing: 5
    readonly property int margins: 20

    implicitWidth: layout.implicitWidth + margins
    implicitHeight: layout.implicitHeight + margins

    border.width: 1
    radius: 10
    clip: true
    color: Style.palette.mantle

    ColumnLayout {
        id: layout
        x: (parent.width - width) / 2
        y: root.margins / 2

        WeatherPopup {
            id: weather
            implicitWidth: calendar.implicitWidth
        }

        CalendarPopup {
            id: calendar
        }
    }
}
