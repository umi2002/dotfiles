pragma ComponentBehavior: Bound

import QtQuick

import qs.services

Rectangle {
    id: root
    required property var device
    readonly property bool isConnectedDevice: device.address === BluetoothData.connectedDevice?.address

    clip: true
    implicitHeight: deviceHeader.implicitHeight + (deviceHeader.isExpanded ? deviceInfoLoader.implicitHeight : 0)
    color: "transparent"

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.InOutCubic
        }
    }

    DeviceHeader {
        id: deviceHeader
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top

        deviceName: root.device.name
        isConnected: root.isConnectedDevice
    }

    Loader {
        id: deviceInfoLoader
        active: root.isConnectedDevice
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: deviceHeader.bottom

        sourceComponent: DeviceInfo {}
    }
}
