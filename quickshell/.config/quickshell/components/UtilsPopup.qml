import QtQuick
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    id: root
    required property bool isHovered

    implicitWidth: controls.implicitWidth + 20
    implicitHeight: isHovered ? controls.implicitHeight + 20 : 0
    border.width: 2
    border.color: Style.palette.border1
    color: "#cc" + Style.palette.background1.toString().substring(1)
    radius: 10

    Rectangle {
        id: controls
        implicitWidth: layout.implicitWidth + 20
        implicitHeight: layout.implicitHeight + 20
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 10
        color: Style.palette.background2

        ColumnLayout {
            id: layout
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.horizontalCenter: parent.horizontalCenter

            UtilsSlider {
                value: Brightness.brightnessPercent
                icon: Brightness.brightnessIcon
                setValueCallback: Brightness.setBrightness
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredHeight: 1
                color: Style.palette.color1
                opacity: 0.2
            }

            UtilsSlider {
                value: Audio.volume
                icon: Audio.volumeIcon
                setValueCallback: Audio.setVolume
                Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            }
        }
    }
}
