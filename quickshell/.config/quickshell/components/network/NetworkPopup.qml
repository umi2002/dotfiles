pragma ComponentBehavior: Bound

import QtQuick.Layouts

import qs.services

ColumnLayout {
    spacing: 30

    NetworkPopupHeader {}

    NetworkSection {
        title: "Saved Networks"
        networkModel: Network.knownNetworks
        isVisible: Network.isWiFiOn
    }

    NetworkSection {
        title: "Available Networks"
        networkModel: Network.unknownNetworks
        isVisible: Network.isWiFiOn
    }
}
