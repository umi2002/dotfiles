pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs
import qs.components

import qs.services

ColumnLayout {
    spacing: Style.spacing.large

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
