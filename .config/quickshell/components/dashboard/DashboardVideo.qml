pragma ComponentBehavior: Bound

import QtMultimedia

import qs
import qs.assets

DashboardSection {

    Video {
        anchors.fill: parent
        anchors.margins: Style.spacing.normal
        source: Assets.dashboardVideo
        autoPlay: true
        loops: MediaPlayer.Infinite
    }
}
