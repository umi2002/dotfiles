import QtQuick
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    id: root
    required property bool isHovered
    implicitWidth: layout.width + 20
    implicitHeight: isHovered ? layout.height + 20 : 0

    color: Style.palette.background1
    radius: 10

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

        UtilsSlider {
            value: Audio.volume
            icon: Audio.volumeIcon
            setValueCallback: Audio.setVolume
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }
    }
}
