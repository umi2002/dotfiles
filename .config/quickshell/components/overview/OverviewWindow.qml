pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs
import qs.services

Rectangle {
    id: root

    required property var toplevel
    required property var overview

    implicitHeight: 26
    radius: Style.radius.small
    color: mouseArea.containsMouse ? Style.palette.surface2 : Style.palette.surface0

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: Style.spacing.small
        anchors.rightMargin: Style.spacing.small
        spacing: Style.spacing.small

        IconImage {
            source: HyprlandData.resolveIcon(root.toplevel?.lastIpcObject?.class ?? "")
            implicitSize: 16
            Layout.alignment: Qt.AlignVCenter
        }

        Text {
            text: root.toplevel?.title ?? ""
            elide: Text.ElideRight
            color: Style.palette.text
            font.family: Style.font.family1
            font.pointSize: Style.font.size2
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
        }
    }

    MouseArea {
        id: mouseArea

        property bool moved: false

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onPressed: mouse => {
            moved = false;
            root.overview.beginDrag(root.toplevel, root.overview.mapFromItem(mouseArea, mouse.x, mouse.y));
        }

        onPositionChanged: mouse => {
            if (!pressed)
                return;
            moved = true;
            root.overview.updateDrag(root.overview.mapFromItem(mouseArea, mouse.x, mouse.y));
        }

        onReleased: mouse => {
            if (moved) {
                root.overview.endDrag(root.overview.mapFromItem(mouseArea, mouse.x, mouse.y));
                return;
            }

            root.overview.endDrag(null);
            HyprlandData.focusWindowByAddress(root.toplevel.address);
            OverviewState.visible = false;
        }
    }
}
