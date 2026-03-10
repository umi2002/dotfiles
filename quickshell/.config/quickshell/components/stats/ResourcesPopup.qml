import QtQuick.Layouts

import qs.assets
import qs.services
import qs.components.dashboard

DashboardSection {
    id: root
    readonly property int iconSize: 20

    implicitWidth: 150

    RowLayout {
        anchors.centerIn: parent
        spacing: 10

        ResourcesSlider {
            Layout.alignment: Qt.AlignVCenter

            iconSource: Assets.stats.cpu
            value: StatsData.cpuUsage
        }

        ResourcesSlider {
            Layout.alignment: Qt.AlignVCenter

            iconSource: Assets.stats.memory
            value: StatsData.memUsage
        }

        ResourcesSlider {
            Layout.alignment: Qt.AlignVCenter

            iconSource: Assets.stats.storage
            value: StatsData.diskUsage
        }
    }
}
