import Quickshell.Hyprland
import QtQuick

Text {
    text: Hyprland.activeToplevel?.title || ""
    horizontalAlignment: Text.AlignHCenter
    width: 800
    elide: Text.ElideRight
}
