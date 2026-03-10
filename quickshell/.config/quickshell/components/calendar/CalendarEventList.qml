pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.services
import qs.components.dashboard

DashboardSection {
    id: root

    property var selectedDate: null

    implicitHeight: eventList.implicitHeight + 20

    ColumnLayout {
        id: eventList
        anchors.centerIn: parent

        Repeater {
            model: {
                Calendar.events;
                return root.selectedDate !== null ? Calendar.eventsForDate(root.selectedDate) : [];
            }
            delegate: RowLayout {
                id: layout

                required property var modelData
                Layout.fillWidth: true
                spacing: 5

                Rectangle {
                    readonly property int size: 6

                    Layout.preferredWidth: size
                    Layout.preferredHeight: size
                    radius: size / 2
                    color: Style.palette.green
                    Layout.alignment: Qt.AlignVCenter
                }

                Text {
                    text: layout.modelData.allDay ? layout.modelData.summary : Qt.formatTime(layout.modelData.dtstart, "h:mm AP") + "  " + layout.modelData.summary
                    color: Style.palette.text
                    font.family: Style.font.family3
                    font.pixelSize: Style.font.size1
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }
            }
        }

        Text {
            visible: root.selectedDate === null || Calendar.eventsForDate(root.selectedDate).length === 0
            text: "No events"
            color: Style.palette.subtext1
            font.family: Style.font.family3
            font.pixelSize: Style.font.size1
            opacity: 0.4
        }
    }
}
