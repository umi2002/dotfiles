import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs
import qs.components

RowLayout {
    id: root
    required property int value
    required property string icon
    required property var setValueCallback

    ColorizedIcon {
        id: iconImage
        iconSource: Qt.resolvedUrl(root.icon)
        iconColor: Style.palette.color1
        implicitSize: 30
    }

    HorizontalSlider {
        id: slider
        Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        sliderWidth: 350
        sliderHeight: 10

        value: root.value
        from: 0
        to: 100

        onValueChange: {
            return root.setValueCallback;
        }
    }
}
