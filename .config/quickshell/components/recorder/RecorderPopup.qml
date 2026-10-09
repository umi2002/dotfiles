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
            text: "Screen recording"
            font.pointSize: Style.font.size1
            font.family: Style.font.family1
            color: Style.palette.text
            Layout.alignment: Qt.AlignLeft
        }

        RowLayout {
            spacing: Style.spacing.normal

            RecorderPreview {
                implicitWidth: 320
                implicitHeight: 180
                screenSource: Recorder.previewScreen
                cropped: Recorder.sourceKind === "region"
                cropX: Recorder.regionX
                cropY: Recorder.regionY
                cropW: Recorder.regionW
                cropH: Recorder.regionH
                placeholder: Recorder.selecting ? "selecting..." : "No source selected"
                Layout.alignment: Qt.AlignVCenter
            }

            ColumnLayout {
                spacing: Style.spacing.small
                Layout.alignment: Qt.AlignVCenter

                RecorderOption {
                    label: "Monitor"
                    selected: Recorder.sourceKind === "monitor"
                    onPicked: Recorder.setKind("monitor")
                }

                RecorderOption {
                    label: "Region"
                    selected: Recorder.sourceKind === "region"
                    onPicked: Recorder.setKind("region")
                }
            }
        }

        Text {
            text: Recorder.sourceLabel
            font.pointSize: Style.font.size2
            font.family: Style.font.family2
            color: Recorder.sourceSelected ? Style.palette.subtext0 : Style.palette.overlay1
            elide: Text.ElideMiddle
            Layout.maximumWidth: 400
            Layout.fillWidth: true
        }

        RowLayout {
            spacing: Style.spacing.small
            Layout.fillWidth: true

            Text {
                text: "Audio"
                font.pointSize: Style.font.size2
                font.family: Style.font.family3
                color: Style.palette.subtext1
                Layout.minimumWidth: 50
                Layout.alignment: Qt.AlignVCenter
            }

            RecorderOption {
                label: "System"
                selected: Recorder.audioSystem
                onPicked: Recorder.audioSystem = !Recorder.audioSystem
            }

            RecorderOption {
                label: "Mic"
                selected: Recorder.audioMic
                onPicked: Recorder.audioMic = !Recorder.audioMic
            }
        }

        StyledButton {
            text: Recorder.selecting ? "Cancel selection" : (Recorder.sourceKind === "region" ? "Select region" : "Select monitor")
            buttonWidth: layout.implicitWidth
            backgroundColor: Style.palette.surface0
            textColor: Style.palette.text
            borderWidth: 0
            opacity: Recorder.recording || Recorder.starting ? 0.5 : 1
            Layout.fillWidth: true

            onClicked: {
                if (Recorder.recording || Recorder.starting)
                    return;
                if (Recorder.selecting) {
                    Recorder.cancel();
                    return;
                }
                if (Recorder.sourceKind === "region") {
                    Recorder.selectRegion();
                    RecorderState.visible = false;
                    return;
                }
                RecorderState.visible = false;
                RecorderState.monitorPickerVisible = true;
            }
        }

        StyledButton {
            text: Recorder.recording ? "Stop" : (Recorder.starting ? "Cancel" : "Start recording")
            buttonWidth: layout.implicitWidth
            backgroundColor: Recorder.recording ? Style.palette.surface1 : Style.palette.surface0
            textColor: Recorder.recording ? Style.palette.red : (Recorder.starting ? Style.palette.yellow : (Recorder.sourceSelected ? Style.palette.green : Style.palette.overlay0))
            borderWidth: 0
            opacity: Recorder.sourceSelected || Recorder.recording || Recorder.starting ? 1 : 0.5
            Layout.fillWidth: true

            onClicked: {
                if (Recorder.recording) {
                    Recorder.stop();
                    return;
                }
                if (Recorder.starting) {
                    Recorder.cancel();
                    return;
                }
                if (!Recorder.sourceSelected || Recorder.selecting)
                    return;
                Recorder.start();
                RecorderState.visible = false;
            }
        }

        Text {
            visible: Recorder.errorMessage !== ""
            text: Recorder.errorMessage
            font.pointSize: Style.font.size2
            font.family: Style.font.family3
            color: Style.palette.red
            wrapMode: Text.Wrap
            Layout.maximumWidth: 400
            Layout.fillWidth: true
        }

        Text {
            visible: Recorder.lastFileName !== "" && !Recorder.active && Recorder.errorMessage === ""
            text: "Saved " + Recorder.lastFileName
            font.pointSize: Style.font.size2
            font.family: Style.font.family2
            color: Style.palette.subtext0
            elide: Text.ElideMiddle
            Layout.maximumWidth: 400
            Layout.fillWidth: true
        }
    }
}
