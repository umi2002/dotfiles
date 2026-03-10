pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs

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
                        radius: 10
                    }

                    MediaInfo {
                        id: mediaInfo
                        implicitWidth: 400
                    }
                }

                RowLayout {
                    spacing: root.spacing

                    TrackLength {
                        id: trackLength
                        radius: 10
                        implicitWidth: mediaInfo.implicitWidth
                    }

                    MediaControls {
                        id: controls
                        implicitWidth: mediaArt.height
                        implicitHeight: trackLength.implicitHeight
                    }
                }
            }

            MediaVolume {
                Layout.preferredWidth: 50
                Layout.fillHeight: true
            }
        }

        AudioVisualiser {
            id: audioVisualiser
            implicitWidth: parent.width
        }
    }
}
