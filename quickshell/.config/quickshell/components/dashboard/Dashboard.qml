import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.services
import qs.assets
import qs.components
import qs.components.calendar
import qs.components.stats

WrapperMouseArea {
    id: root

    readonly property int resourceWidth: 80
    readonly property int resourceHeight: 30

    hoverEnabled: true

    RowLayout {
        spacing: 10

        Resource {
            Layout.preferredWidth: root.resourceWidth
            Layout.preferredHeight: root.resourceHeight
            Layout.alignment: Qt.AlignVCenter

            fgColor: Style.palette.crust
            bgColor: Style.palette.sapphire
            iconSource: Assets.stats.cpu
            value: StatsData.cpuUsage
        }

        Resource {
            Layout.preferredWidth: root.resourceWidth
            Layout.preferredHeight: root.resourceHeight
            Layout.alignment: Qt.AlignVCenter

            fgColor: Style.palette.crust
            bgColor: Style.palette.blue
            iconSource: Assets.stats.memory
            value: StatsData.memUsage
        }

        Resource {
            Layout.preferredWidth: root.resourceWidth
            Layout.preferredHeight: root.resourceHeight
            Layout.alignment: Qt.AlignVCenter

            fgColor: Style.palette.crust
            bgColor: Style.palette.peach
            iconSource: Assets.stats.storage
            value: StatsData.diskUsage
        }

        Calendar {
            Layout.alignment: Qt.AlignVCenter
        }
    }
}
