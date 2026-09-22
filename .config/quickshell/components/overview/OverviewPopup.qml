pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.components
import qs.services

StyledPopupContent {
    id: root

    property var dragToplevel: null
    property string dragTitle: ""

    readonly property int cardWidth: 190
    readonly property int cardHeight: 130

    implicitWidth: grid.implicitWidth + Style.spacing.large
    implicitHeight: grid.implicitHeight + Style.spacing.large

    function beginDrag(toplevel, pos) {
        root.dragToplevel = toplevel;
        root.dragTitle = toplevel?.title ?? "";
        root.updateDrag(pos);
    }

    function updateDrag(pos) {
        ghost.x = pos.x - ghost.width / 2;
        ghost.y = pos.y - ghost.height / 2;
    }

    function endDrag(pos) {
        const toplevel = root.dragToplevel;
        root.dragToplevel = null;

        if (!toplevel || !pos)
            return;

        for (let i = 0; i < repeater.count; i++) {
            const card = repeater.itemAt(i);
            const local = root.mapToItem(card, pos.x, pos.y);
            if (local.x < 0 || local.y < 0 || local.x > card.width || local.y > card.height)
                continue;
            if (card.workspaceId !== toplevel.workspace?.id)
                HyprlandData.moveWindowToWorkspace(toplevel.address, card.workspaceId);
            return;
        }
    }

    GridLayout {
        id: grid

        anchors.centerIn: parent
        columns: 5
        columnSpacing: Style.spacing.normal
        rowSpacing: Style.spacing.normal

        Repeater {
            id: repeater

            model: HyprlandData.nWorkspaces

            delegate: OverviewWorkspace {
                required property int index

                workspaceId: index + 1
                overview: root
                Layout.preferredWidth: root.cardWidth
                Layout.preferredHeight: root.cardHeight
            }
        }
    }

    Rectangle {
        id: ghost

        visible: root.dragToplevel !== null
        width: 160
        height: 26
        radius: Style.radius.small
        color: Style.palette.surface2
        opacity: 0.9
        z: 1

        Text {
            anchors.fill: parent
            anchors.leftMargin: Style.spacing.small
            anchors.rightMargin: Style.spacing.small
            text: root.dragTitle
            elide: Text.ElideRight
            color: Style.palette.text
            font.family: Style.font.family1
            font.pointSize: Style.font.size2
            verticalAlignment: Text.AlignVCenter
        }
    }
}
