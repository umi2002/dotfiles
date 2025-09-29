import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

Item {
    id: root
    readonly property bool isHovered: popupMouseArea.containsMouse || utilsMouseArea.containsMouse
    implicitHeight: Math.max(popup.height, utils.height)
    implicitWidth: popup.width

    WrapperMouseArea {
        id: popupMouseArea
        hoverEnabled: true
        anchors.right: utilsMouseArea.right
        anchors.bottom: utilsMouseArea.top

        UtilsPopup {
            id: popup
            isHovered: root.isHovered
            anchors.margins: 20
            clip: true

            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 400
                    easing.type: Easing.InOutBack
                }
            }
        }
    }

    WrapperMouseArea {
        id: utilsMouseArea
        hoverEnabled: true
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter

        Rectangle {
            id: utils
            implicitWidth: layout.width + 20
            implicitHeight: layout.height + 5
            radius: height / 2
            color: Style.palette.background2

            RowLayout {
                id: layout
                anchors.centerIn: parent

                Brightness {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: childrenRect.width
                    Layout.preferredHeight: childrenRect.height
                }

                Rectangle {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: 2
                    Layout.preferredHeight: parent.height - 5
                    Layout.leftMargin: 5
                    Layout.rightMargin: 5
                    color: Style.palette.color1
                }

                Audio {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredWidth: childrenRect.width
                    Layout.preferredHeight: childrenRect.height
                }
            }
        }
    }
}
