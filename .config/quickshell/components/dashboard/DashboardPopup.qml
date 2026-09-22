pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.components.calendar
import qs.components.weather
import qs.components.stats

StyledPopupContent {
    id: root
    readonly property int spacing: Style.spacing.small
    readonly property int margins: Style.spacing.large

    implicitWidth: layout.implicitWidth + margins
    implicitHeight: layout.implicitHeight + margins


    RowLayout {
        id: layout
        x: (parent.width - width) / 2
        y: root.margins / 2

        ColumnLayout {
            Layout.fillHeight: true

            DashboardVideo {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            RowLayout {
                Layout.preferredHeight: statsPopup.implicitHeight

                StatsPopup {
                    id: statsPopup
                }

                ResourcesPopup {
                    Layout.preferredHeight: statsPopup.implicitHeight
                }
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
