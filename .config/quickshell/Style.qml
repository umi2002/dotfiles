pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick

QtObject {
    readonly property var palette: QtObject {
        // Catppuccin Moccha
        readonly property color rosewater: "#f5e0dc" // Cursor
        readonly property color flamingo: "#f2cdcd"
        readonly property color pink: "#f5c2e7"
        readonly property color mauve: "#cba6f7"
        readonly property color red: "#f38ba8" // Errors
        readonly property color maroon: "#eba0ac"
        readonly property color peach: "#fab387"
        readonly property color yellow: "#f9e2af" // Warnings
        readonly property color green: "#a6e3a1" // Success
        readonly property color teal: "#94e2d5"
        readonly property color sky: "#89dceb"
        readonly property color sapphire: "#74c7ec"
        readonly property color blue: "#89b4fa" // Tags, Pills
        readonly property color lavender: "#b4befe"
        readonly property color text: "#cdd6f4" // Body Copy, Main Headline
        readonly property color subtext1: "#bac2de" // Sub-Headlines, Labels
        readonly property color subtext0: "#a6adc8" // Sub-Headlines, Labels
        readonly property color overlay2: "#9399b2" // Overlays, Selection Background, 20-30% Opacity
        readonly property color overlay1: "#7f849c" // Overlays, Subtle
        readonly property color overlay0: "#6c7086" // Overlays
        readonly property color surface2: "#585b70" // Surface Elements
        readonly property color surface1: "#45475a" // Surface Elements
        readonly property color surface0: "#313244" // Surface Elements
        readonly property color base: "#1e1e2e" // Background Pane, On Accent
        readonly property color mantle: "#181825" // Secondary Panes
        readonly property color crust: "#11111b" // Secondary Panes
    }

    readonly property var font: QtObject {
        readonly property string family1: "Cantarell"
        readonly property string family2: "CaskaydiaCove Nerd Font Mono"
        readonly property string family3: "Noto Sans Mono CJK"
        readonly property string family4: "JetBrainsMono Nerd Font"
        readonly property int size1: 16
        readonly property int size2: 12
    }

    readonly property var animation: QtObject {
        readonly property int fast: 150
        readonly property int normal: 200
        readonly property int slow: 300
        readonly property int popup: 450
        readonly property var curve: [0.05, 0.7, 0.1, 1.0, 1.0, 1.0]
    }

    readonly property var spacing: QtObject {
        readonly property int small: 5
        readonly property int normal: 10
        readonly property int large: 20
    }

    readonly property var radius: QtObject {
        readonly property int small: 10
        readonly property int large: 20
    }
}
