pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs
import qs.components

StyledPopupContent {
    id: root
    readonly property int spacing: Style.spacing.small
    readonly property int margins: Style.spacing.large

    implicitWidth: layout.implicitWidth + margins
    implicitHeight: layout.implicitHeight + margins


    ColumnLayout {
        id: layout
        x: (parent.width - width) / 2
        y: root.margins / 2
        spacing: root.spacing

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
                        radius: Style.radius.small
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
                        radius: Style.radius.small
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
