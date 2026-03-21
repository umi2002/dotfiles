pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.services
import qs.components
import qs.components.dashboard

DashboardSection {
    id: root

    readonly property int iconSize: 20
    readonly property int spacing: 20
    readonly property int fontSize: 16

    implicitWidth: layout.implicitWidth + 50
    implicitHeight: layout.implicitHeight + 50

    ColumnLayout {
        id: layout
        anchors.centerIn: parent

        RowLayout {
            spacing: root.spacing

            ColorizedIcon {
                Layout.alignment: Qt.AlignHCenter
                iconSource: Assets.stats.os
                iconColor: "transparent"
                implicitSize: root.iconSize
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: StatsData.os
                color: Style.palette.text
                font.family: Style.font.family3
                font.pixelSize: root.fontSize
            }
        }

        RowLayout {
            spacing: root.spacing

            ColorizedIcon {
                Layout.alignment: Qt.AlignHCenter
                iconSource: Assets.stats.kernel
                iconColor: Style.palette.green
                implicitSize: root.iconSize
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: StatsData.kernel
                color: Style.palette.text
                font.family: Style.font.family3
                font.pixelSize: root.fontSize
            }
        }

        RowLayout {
            spacing: root.spacing

            ColorizedIcon {
                Layout.alignment: Qt.AlignHCenter
                iconSource: Assets.stats.wm
                iconColor: Style.palette.green
                implicitSize: root.iconSize
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: StatsData.wm
                color: Style.palette.text
                font.family: Style.font.family3
                font.pixelSize: root.fontSize
            }
        }

        RowLayout {
            spacing: root.spacing

            ColorizedIcon {
                Layout.alignment: Qt.AlignHCenter
                iconSource: Assets.stats.cpu
                iconColor: Style.palette.green
                implicitSize: root.iconSize
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: StatsData.cpu
                color: Style.palette.text
                font.family: Style.font.family3
                font.pixelSize: root.fontSize
            }
        }

        RowLayout {
            spacing: root.spacing

            ColorizedIcon {
                Layout.alignment: Qt.AlignHCenter
                iconSource: Assets.stats.gpu
                iconColor: Style.palette.green
                implicitSize: root.iconSize
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: StatsData.gpu
                color: Style.palette.text
                font.family: Style.font.family3
                font.pixelSize: root.fontSize
            }
        }

        RowLayout {
            spacing: root.spacing

            ColorizedIcon {
                Layout.alignment: Qt.AlignHCenter
                iconSource: Assets.stats.uptime
                iconColor: Style.palette.green
                implicitSize: root.iconSize
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: StatsData.uptime
                color: Style.palette.text
                font.family: Style.font.family3
                font.pixelSize: root.fontSize
            }
        }
    }
}
