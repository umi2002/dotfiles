pragma ComponentBehavior: Bound

import Quickshell.Networking
import QtQuick

import qs
import qs.services

Rectangle {
    id: root

    implicitHeight: networkInfo.implicitHeight
    color: "transparent"

    readonly property list<string> text: ["Security type: " + root.securityTypeToString(NetworkData.connectedNetwork?.security), "Signal strength: " + NetworkData.connectedNetwork?.signalStrength * 100]

    Text {
        id: networkInfo
        text: root.text.join("\n")
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: Style.palette.text
    }

    function securityTypeToString(securityType) {
        switch (securityType) {
        case WifiSecurityType.WpaEap:
            return "WpaEap";
        case WifiSecurityType.Wpa3SuiteB192:
            return "Wpa3SuiteB192";
        case WifiSecurityType.DynamicWep:
            return "DynamicWep";
        case WifiSecurityType.Wpa2Eap:
            return "Wpa2Eap";
        case WifiSecurityType.Wpa2Psk:
            return "Wpa2Psk";
        case WifiSecurityType.Leap:
            return "Leap";
        case WifiSecurityType.Owe:
            return "Owe";
        case WifiSecurityType.Unknown:
            return "Unknown";
        case WifiSecurityType.WpaPsk:
            return "WpaPsk";
        case WifiSecurityType.StaticWep:
            return "StaticWep";
        case WifiSecurityType.Open:
            return "Open";
        case WifiSecurityType.Sae:
            return "Sae";
        default:
            return "Unknown";
        }
    }
}
