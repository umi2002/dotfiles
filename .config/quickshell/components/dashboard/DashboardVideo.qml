import QtMultimedia

import qs.assets

DashboardSection {

    Video {
        anchors.fill: parent
        anchors.margins: 10
        source: Assets.dashboardVideo
        autoPlay: true
        loops: MediaPlayer.Infinite
    }
}
