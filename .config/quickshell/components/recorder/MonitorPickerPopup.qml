pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.services

StyledPopupContent {
    id: root

    readonly property int margins: Style.spacing.large

    implicitWidth: layout.implicitWidth + root.margins * 2
    implicitHeight: layout.implicitHeight + root.margins * 2

    ColumnLayout {
        id: layout

        x: root.margins
        y: root.margins
        spacing: Style.spacing.normal

        Text {
            text: "Select a monitor"
            font.pointSize: Style.font.size1
            font.family: Style.font.family1
            color: Style.palette.text
            Layout.alignment: Qt.AlignLeft
        }

        RowLayout {
            spacing: Style.spacing.small
            Layout.alignment: Qt.AlignHCenter

            Repeater {
                model: Quickshell.screens

                RecorderMonitorCard {
                    required property var modelData

                    screenSource: modelData
                    selected: Recorder.sourceKind === "monitor" && Recorder.targetMonitor === modelData.name

                    onPicked: {
                        Recorder.pickMonitor(modelData.name);
                        RecorderState.monitorPickerVisible = false;
                        RecorderState.visible = true;
                    }
                }
            }
        }
    }
}
