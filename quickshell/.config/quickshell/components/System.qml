import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

Item {
    id: root
    readonly property bool isHovered: popupMouseArea.containsMouse || systemMouseArea.containsMouse
    implicitHeight: Math.max(popup.height, system.height)
    implicitWidth: Math.max(popup.width, system.width)

    WrapperMouseArea {
        id: popupMouseArea
        hoverEnabled: true
        anchors.left: systemMouseArea.left
        anchors.bottom: systemMouseArea.top

        SystemPopup {
            id: popup
            implicitWidth: root.isHovered ? 600 : 0
            implicitHeight: root.isHovered ? 200 : 0
            clip: true

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutBack
                }
            }

            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutBack
                }
            }
        }
    }

    WrapperMouseArea {
        id: systemMouseArea
        hoverEnabled: true
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: system
            implicitWidth: layout.width + 20
            implicitHeight: layout.height + 5
            radius: height / 2
            color: Style.palette.background2

            RowLayout {
                id: layout
                anchors.centerIn: parent
                spacing: 20

                Network {
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredWidth: childrenRect.width
                    Layout.preferredHeight: childrenRect.height
                    implicitSize: 30
                }

                Bluetooth {}
            }
        }
    }
}
