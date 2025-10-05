pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root
    required property bool isHovered
    readonly property int spacing: 5

    implicitWidth: content.implicitWidth
    implicitHeight: isHovered ? content.implicitHeight : 0
    border.width: 1
    border.color: Style.palette.border1
    color: "#bf" + Style.palette.background1.toString().substring(1)
    radius: 10

    Rectangle {
        id: content
        implicitWidth: layout.implicitWidth + 20
        implicitHeight: layout.implicitHeight + 20
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"

        ColumnLayout {
            id: layout
            anchors.centerIn: parent

            RowLayout {
                spacing: root.spacing

                ColumnLayout {
                    spacing: root.spacing

                    RowLayout {
                        spacing: root.spacing

                        MediaArt {
                            id: mediaArt
                            Layout.preferredWidth: height
                            Layout.preferredHeight: mediaInfo.implicitHeight
                            Layout.alignment: Qt.AlignVCenter
                            color: Style.palette.background2
                            radius: 10
                        }

                        MediaInfo {
                            id: mediaInfo
                            implicitWidth: 400
                            color: Style.palette.background2
                            radius: 10
                        }
                    }

                    RowLayout {
                        spacing: root.spacing

                        TrackLength {
                            id: trackLength
                            color: Style.palette.background2
                            radius: 10
                            implicitWidth: mediaInfo.implicitWidth
                        }

                        MediaControls {
                            id: controls
                            implicitWidth: mediaArt.height
                            implicitHeight: trackLength.implicitHeight
                            color: Style.palette.background2
                            radius: 10
                        }
                    }
                }

                MediaVolume {
                    Layout.fillHeight: true
                    color: Style.palette.background2
                    radius: 10
                }
            }

            Loader {
                active: root.isHovered
                Layout.fillWidth: true

                sourceComponent: AudioVisualiser {
                    id: audioVisualiser
                    color: Style.palette.background2
                    implicitWidth: parent.width
                    radius: 10
                }
            }
        }
    }
}
