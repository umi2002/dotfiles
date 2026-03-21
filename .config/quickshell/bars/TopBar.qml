import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.services
import qs.components
import qs.components.dashboard
import qs.components.workspaces
import qs.components.runner

Rectangle {
    id: root
    readonly property alias runnerPopupItem: runnerPopup
    readonly property alias dashboardPopupItem: dashboardPopup
    readonly property int margins: 10
    property bool showRunner: true

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    IconImage {
        id: logo
        source: Assets.archLinux
        implicitSize: 30
        Layout.alignment: Qt.AlignVCenter
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
    }

    Workspaces {
        Layout.alignment: Qt.AlignVCenter
        radius: Math.min(width, height) / 2
        anchors.left: logo.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
    }

    StyledPopup {
        id: runnerPopup
        isExpanded: RunnerState.visible && root.showRunner
        anchors.top: title.bottom
        anchors.horizontalCenter: title.horizontalCenter
        popupContent: RunnerPopup {}
    }

    Title {
        id: title
        anchors.centerIn: parent
        color: Style.palette.text
        font.family: Style.font.family1
        font.pointSize: Style.font.size1
    }

    StyledPopup {
        id: dashboardPopup
        isExpanded: containsMouse || dashboard.containsMouse
        anchors.right: dashboard.right
        anchors.top: dashboard.bottom
        popupContent: DashboardPopup {}
    }

    Dashboard {
        id: dashboard
        anchors.right: parent.right
        anchors.rightMargin: root.margins
        anchors.verticalCenter: parent.verticalCenter
    }
}
