import QtQuick
import QtQuick.Layouts

import qs.services
import "../Style.js" as Style

Rectangle {
    id: root

    color: Style.palette.background1
    radius: 10

    ColumnLayout {
        id: layout
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: root.implicitWidth - 20

        UtilsSlider {
            value: Brightness.brightnessPercent
            icon: Brightness.brightnessIcon
            setValueCallback: Brightness.setBrightness
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.preferredWidth: layout.width
        }

        UtilsSlider {
            value: Audio.volume
            icon: Audio.volumeIcon
            setValueCallback: Audio.setVolume
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            Layout.preferredWidth: layout.width
        }
    }
}
