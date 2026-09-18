pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

import qs.services

Rectangle {
    id: root
    readonly property ScriptModel trayItems: Tray.trayModel

    implicitWidth: listView.implicitWidth
    color: "transparent"

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
            required property SystemTrayItem modelData
            readonly property SystemTrayItem item: modelData
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                const itemName = (trayItem.item?.id ?? "").toLowerCase().split(/[^a-z0-9]+/)[0];
                const matchedClass = itemName ? HyprlandData.windowClasses.find(cls => cls.toLowerCase().split(/[^a-z0-9]+/).includes(itemName)) : undefined;

                if (matchedClass) {
                    HyprlandData.focusWindow(matchedClass);
                } else {
                    trayItem.item?.activate();
                }
            }

            IconImage {

                source: trayItem.item?.icon ?? ""
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
