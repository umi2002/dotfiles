import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import qs.components
import "../Style.js" as Style

Item {
    id: root
    readonly property bool isHovered: popupMouseArea.containsMouse || utilsMouseArea.containsMouse
    implicitWidth: utils.implicitWidth
    implicitHeight: utils.implicitHeight

    WrapperMouseArea {
        id: popupMouseArea
        hoverEnabled: true
        anchors.right: utilsMouseArea.right
        anchors.bottom: utilsMouseArea.top

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            implicitWidth: popup.implicitWidth
            implicitHeight: popup.implicitHeight
            color: "transparent"

            UtilsPopup {
                id: popup
                isHovered: root.isHovered
                clip: true

                Behavior on implicitHeight {
                    NumberAnimation {
                        duration: 400
                        easing.type: Easing.InOutBack
                    }
                }
            }
        }
    }

    WrapperMouseArea {
        id: utilsMouseArea
        hoverEnabled: true

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
                    opacity: 0.4
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
