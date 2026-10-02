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

    ListSection {
        Layout.fillHeight: true
        title: "Saved Networks"
        sectionModel: NetworkData.knownNetworks
        delegateComponent: NetworkListViewItem {
            width: ListView.view.width
        }
        isVisible: NetworkData.isWiFiOn
    }

    ListSection {
        Layout.fillHeight: true
        title: "Available Networks"
        sectionModel: NetworkData.unknownNetworks
        delegateComponent: NetworkListViewItem {
            width: ListView.view.width
        }
        isVisible: NetworkData.isWiFiOn
    }
}
