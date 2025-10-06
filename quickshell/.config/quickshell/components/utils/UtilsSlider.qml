import QtQuick.Layouts

import qs
import qs.components

RowLayout {
    id: root

    required property int value
    required property string icon
    required property var setValueCallback

    property int iconSize: 30
    property int sliderWidth: 350
    property int sliderHeight: 10

    ColorizedIcon {
        iconSource: Qt.resolvedUrl(root.icon)
        iconColor: Style.palette.color1
        implicitSize: root.iconSize
    }

    HorizontalSlider {
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        sliderWidth: root.sliderWidth
        sliderHeight: root.sliderHeight

        value: root.value
        from: 0
        to: 100

        onValueChange: root.setValueCallback
    }
}
