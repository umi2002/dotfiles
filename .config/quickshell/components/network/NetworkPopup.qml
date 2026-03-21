pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts

import qs.services

ColumnLayout {
    spacing: 30

    NetworkPopupHeader {}

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
