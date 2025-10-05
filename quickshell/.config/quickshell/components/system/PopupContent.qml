import QtQuick
import QtQuick.Controls

import qs.components

ScrollView {
    id: root
    required property int selectedIndex
    required property int popupWidth

    ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
    contentWidth: container.width
    contentHeight: container.height

    Item {
        id: container
        implicitWidth: root.width
        implicitHeight: slider.implicitHeight

        ContentSlider {
            id: slider
            currentIndex: root.selectedIndex
            containerWidth: container.width
            popupWidth: root.popupWidth

            networkContent: NetworkPopup {
                anchors.fill: parent
            }

            bluetoothContent: BluetoothPopup {
                anchors.fill: parent
            }
        }
    }
}
