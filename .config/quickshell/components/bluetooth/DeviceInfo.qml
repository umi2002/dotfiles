pragma ComponentBehavior: Bound

import QtQuick

import qs
import qs.services

Rectangle {
    id: root

    required property var device

    readonly property list<string> text: {
        const lines = ["Status: " + BluetoothData.deviceStatus(device)];
        const battery = BluetoothData.deviceBattery(device);
        if (battery >= 0)
            lines.push("Battery: " + battery + "%");
        if (device?.icon)
            lines.push("Type: " + device.icon.replace(/^audio-/, "").replace(/-/g, " "));
        lines.push("Address: " + (device?.address ?? ""));
        lines.push("Trusted: " + (device?.trusted ? "Yes" : "No"));
        return lines;
    }

    implicitHeight: deviceInfo.implicitHeight
    color: "transparent"

    Text {
        id: deviceInfo
        text: root.text.join("\n")
        font.pointSize: Style.font.size2
        font.family: Style.font.family3
        color: Style.palette.text
    }
}
