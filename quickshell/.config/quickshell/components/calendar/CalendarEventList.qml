pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.services

ColumnLayout {
    id: root

    property var selectedDate: null

    visible: root.selectedDate !== null
    spacing: 6

    Rectangle {
        Layout.fillWidth: true
        height: 1
        color: Style.palette.border1
        opacity: 0.4
    }

    Repeater {
        model: {
            Calendar.events;
            return root.selectedDate !== null ? Calendar.eventsForDate(root.selectedDate) : [];
        }
        delegate: RowLayout {
            required property var modelData
            Layout.fillWidth: true
            spacing: 8

            Rectangle {
                readonly property int size: 6

                width: size
                height: size
                radius: size / 2
                color: Style.palette.color2
                Layout.alignment: Qt.AlignVCenter
            }

            Text {
                text: modelData.allDay ? modelData.summary : Qt.formatTime(modelData.dtstart, "h:mm AP") + "  " + modelData.summary
                color: Style.palette.color1
                font.family: Style.font.family3
                font.pixelSize: Style.font.size1
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }
    }

    Text {
        visible: {
            Calendar.events;
            return root.selectedDate !== null && Calendar.eventsForDate(root.selectedDate).length === 0;
        }
        text: "No events"
        color: Style.palette.color1
        font.family: Style.font.family3
        font.pixelSize: Style.font.size1
        opacity: 0.4
    }
}
