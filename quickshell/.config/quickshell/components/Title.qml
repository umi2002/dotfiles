import Quickshell.Hyprland
import QtQuick

Text {
    text: Hyprland.activeToplevel?.title || ""
}
