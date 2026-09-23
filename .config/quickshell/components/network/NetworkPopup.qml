pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.components

import qs.services

ColumnLayout {
    spacing: 30

    ToggleHeader {
        label: "Wi-Fi"
        checked: NetworkData.isWiFiOn
        onToggled: NetworkData.toggleWiFi()
    }

    NetworkSection {
        Layout.fillHeight: true
        title: "Saved Networks"
        networkModel: NetworkData.knownNetworks
        isVisible: NetworkData.isWiFiOn
    }

    NetworkSection {
        Layout.fillHeight: true
        title: "Available Networks"
        networkModel: NetworkData.unknownNetworks
        isVisible: NetworkData.isWiFiOn
    }
}
