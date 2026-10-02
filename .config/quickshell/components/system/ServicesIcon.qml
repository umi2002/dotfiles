pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.assets
import qs.components
import qs.services

Row {
    id: root

    property int implicitSize: 30
    readonly property bool healthy: Systemd.failedCount === 0

    spacing: Style.spacing.small

    ColorizedIcon {
        iconSource: root.healthy ? Assets.services.default_ : Assets.services.warning
        iconColor: root.healthy ? Style.palette.green : Style.palette.red
        implicitSize: root.implicitSize
        anchors.verticalCenter: parent.verticalCenter
    }

    Text {
        text: Systemd.failedCount
        visible: !root.healthy
        font.pointSize: Style.font.size2
        font.family: Style.font.family4
        color: Style.palette.red
        anchors.verticalCenter: parent.verticalCenter
    }
}
