pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.components.calendar
import qs.components.weather
import qs.components.stats

Rectangle {
    id: root
    property bool isExpanded
    readonly property int spacing: 5
    readonly property int margins: 20

    implicitWidth: layout.implicitWidth + margins
    implicitHeight: layout.implicitHeight + margins

    radius: 10
    clip: true
    color: Style.palette.base

    RowLayout {
        id: layout
        x: (parent.width - width) / 2
        y: root.margins / 2

        ColumnLayout {
            StatsPopup {
                Layout.alignment: Qt.AlignHCenter
            }

            ResourcesPopup {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }

        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter

            WeatherPopup {
                id: weather
                implicitWidth: calendar.implicitWidth
            }

            CalendarPopup {
                id: calendar
            }
        }
    }
}
