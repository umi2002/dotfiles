pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.services
import qs.components.dashboard

DashboardSection {
    id: root

    implicitHeight: layout.implicitHeight + 30

    function formatWeatherText(value, decimals, unit) {
        return isNaN(value) ? "--" : value.toFixed(decimals) + unit;
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: 40

        IconImage {
            Layout.alignment: Qt.AlignVCenter
            implicitSize: 100

            source: Weather.icon
        }

        ColumnLayout {
            id: layout
            spacing: 10

            Layout.alignment: Qt.AlignVCenter

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: Weather.station
                color: Style.palette.subtext1
                font.family: Style.font.family3
                font.pixelSize: Style.font.size2
                opacity: 0.6
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: root.formatWeatherText(Weather.temperature, 1, " °C")
                color: Style.palette.text
                font.family: Style.font.family3
                font.pixelSize: 48
                font.bold: true
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 10

                Text {
                    text: "Humidity"
                    color: Style.palette.subtext1
                    font.family: Style.font.family3
                    font.pixelSize: Style.font.size2
                    opacity: 0.6
                }

                Text {
                    text: root.formatWeatherText(Weather.humidity, 0, " %")
                    color: Style.palette.subtext1
                    font.family: Style.font.family3
                    font.pixelSize: Style.font.size2
                }
            }
        }
    }
}
