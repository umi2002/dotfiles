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
        title: "Saved Networks"
        networkModel: NetworkData.knownNetworks
        isVisible: NetworkData.isWiFiOn
    }

    NetworkSection {
        title: "Available Networks"
        networkModel: NetworkData.unknownNetworks
        isVisible: NetworkData.isWiFiOn
    }
}
