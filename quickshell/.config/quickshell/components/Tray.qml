pragma ComponentBehavior: Bound

import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQml.Models

import qs.services

Rectangle {
    id: root
    readonly property ListModel trayItems: Tray.trayModel

    implicitWidth: listView.implicitWidth
    color: "transparent"

    function getTrayIcon(icon) {
        if (!icon) {
            return "";
        }

        if (icon.includes("?path=")) {
            const [name, path] = icon.split("?path=");
            icon = Qt.resolvedUrl(`${path}/${name.slice(name.lastIndexOf("/") + 1)}`);
        }

        return icon;
    }

    Behavior on implicitWidth {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutCubic
        }
    }

    ListView {
        id: listView

        model: root.trayItems
        orientation: ListView.Horizontal
        spacing: 5
        implicitWidth: contentWidth
        implicitHeight: 20
        anchors.verticalCenter: parent.verticalCenter

        delegate: WrapperMouseArea {
            id: trayItem
            required property string id
            readonly property SystemTrayItem item: Tray.trayMap[trayItem.id] || null
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                trayItem.item?.activate();
            }

            IconImage {

                source: root.getTrayIcon(trayItem.item?.icon)
                implicitSize: 20
            }
        }

        add: Transition {
            NumberAnimation {
                properties: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                properties: "scale"
                from: 0.5
                to: 1
                duration: 200
                easing.type: Easing.InOutCubic
            }
        }

        remove: Transition {
            NumberAnimation {
                properties: "opacity"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.InOutCubic
            }
            NumberAnimation {
                properties: "scale"
                from: 1
                to: 0.5
                duration: 200
                easing.type: Easing.InOutCubic
            }
        }

        displaced: Transition {
            NumberAnimation {
                properties: "x"
                duration: 200
                easing.type: Easing.InOutCubic
            }
        }
    }
}
