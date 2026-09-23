pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.services
import qs.components
import qs.components.dashboard
import qs.components.workspaces
import qs.components.overview
import qs.components.runner

Rectangle {
    id: root
    readonly property int margins: Style.spacing.normal
    property bool showRunner: true
    required property string screenName

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
        id: workspaces
        Layout.alignment: Qt.AlignVCenter
        radius: Math.min(width, height) / 2
        anchors.left: logo.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
    }

    StyledPopup {
        id: runnerPopup
        isExpanded: RunnerState.visible && root.showRunner && !HyprlandData.hasFullscreen
        dismissable: true
        onDismissed: RunnerState.visible = false
        target: title
        anchors.top: title.bottom
        popupContent: RunnerPopup {}
    }

    OverviewButton {
        id: overviewButton
        screenName: root.screenName
        anchors.left: workspaces.right
        anchors.leftMargin: root.margins
        anchors.verticalCenter: parent.verticalCenter
    }

    StyledPopup {
        id: overviewPopup
        isExpanded: OverviewState.visible && OverviewState.targetScreen === root.screenName && !HyprlandData.hasFullscreen
        dismissable: true
        onDismissed: OverviewState.visible = false
        target: title
        anchors.top: overviewButton.bottom
        popupContent: OverviewPopup {}
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
        target: dashboard
        gravity: Edges.Right
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
