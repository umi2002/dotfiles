import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.assets
import qs.components
import qs.components.dashboard
import qs.components.workspaces

Rectangle {
    id: root
    readonly property bool hasPopup: dashboardPopup.isExpanded
    readonly property int margins: 10

    anchors.leftMargin: margins
    anchors.rightMargin: margins
    color: "transparent"

    Item {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: root.margins
        implicitWidth: childrenRect.width
        implicitHeight: childrenRect.height

        RowLayout {
            spacing: 20

            IconImage {
                source: Assets.archLinux

                implicitSize: 30
                Layout.alignment: Qt.AlignVCenter
            }

            Workspaces {
                Layout.alignment: Qt.AlignVCenter
                radius: Math.min(width, height) / 2
            }
        }
    }

    Title {
        anchors.centerIn: parent
        color: Style.palette.text
        font.family: Style.font.family1
        font.pointSize: Style.font.size1
    }

    Rectangle {
        id: dashboardPopupContainer
        anchors.right: dashboard.right
        anchors.top: dashboard.bottom
        anchors.rightMargin: 10
        width: dashboardPopup.implicitWidth
        height: dashboardPopup.implicitHeight + 20
        color: "transparent"

        MouseArea {
            id: dashboardPopupMouseArea
            enabled: dashboardPopup.implicitHeight > 0
            anchors.fill: parent
            hoverEnabled: true

            StyledPopup {
                id: dashboardPopup
                isExpanded: dashboardPopupMouseArea.containsMouse || dashboard.containsMouse
                anchors.bottom: dashboardPopupMouseArea.bottom
                popupContent: DashboardPopup {}
            }
        }
    }

    Dashboard {
        id: dashboard
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }
}
