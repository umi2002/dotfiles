pragma ComponentBehavior: Bound

import QtQuick

import qs.components.bluetooth
import qs.components.network

Flickable {
    id: root
    required property int selectedIndex

    contentWidth: container.width
    contentHeight: container.height
    flickableDirection: Flickable.VerticalFlick
    interactive: false
    clip: true

    Item {
        id: container
        implicitWidth: root.width
        implicitHeight: tabContent.implicitHeight

        TabContent {
            id: tabContent
            currentIndex: root.selectedIndex
            containerWidth: container.width
            containerHeight: root.height

            networkContent: NetworkPopup {
                anchors.fill: parent
            }

            bluetoothContent: BluetoothPopup {
                anchors.fill: parent
            }

            servicesContent: ServicesPopup {
                anchors.fill: parent
            }
        }
    }
}
