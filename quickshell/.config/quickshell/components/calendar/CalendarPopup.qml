pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import qs
import qs.assets

Rectangle {
    id: root

    property bool isExpanded
    readonly property int margins: 20
    readonly property int borderRadius: 10
    property var viewDate: {
        const date = new Date();
        return new Date(date.getFullYear(), date.getMonth(), 1);
    }
    property var selectedDate: null

    implicitWidth: container.implicitWidth + margins
    implicitHeight: container.implicitHeight + margins

    border.width: 1
    border.color: Style.palette.color1
    radius: borderRadius
    clip: true

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: Style.palette.background1
        }
        GradientStop {
            position: 1.0
            color: Style.palette.background2
        }
    }

    Rectangle {
        id: container
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.margins / 2
        implicitWidth: layout.implicitWidth + root.margins
        implicitHeight: layout.implicitHeight + root.margins
        radius: root.borderRadius
        color: "transparent"

        Rectangle {
            id: bgMask
            anchors.fill: parent
            radius: parent.radius
            visible: false
        }

        ShaderEffect {
            anchors.fill: parent
            fragmentShader: Assets.shaders.waves

            property real time: 0

            NumberAnimation on time {
                from: 0
                to: Math.PI * 2
                duration: 10000
                loops: Animation.Infinite
            }

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: bgMask
            }
        }

        ColumnLayout {
            id: layout
            anchors.centerIn: parent
            spacing: 10

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
    }
}
