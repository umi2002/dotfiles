import QtQuick
import QtQuick.Layouts

import qs
import qs.components

ColumnLayout {
    id: root

    required property string iconSource
    required property real value

    VerticalSlider {
        Layout.alignment: Qt.AlignHCenter
        Layout.fillHeight: true

        sliderWidth: 8
        sliderHeight: 150
        cursorShape: Qt.ArrowCursor
        value: root.value
    }

    ColorizedIcon {
        id: icon
        Layout.alignment: Qt.AlignHCenter

        iconSource: root.iconSource
        iconColor: Style.palette.green
        implicitSize: 30
    }
}
