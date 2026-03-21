import Quickshell
import Quickshell.Hyprland

import qs.bars
import qs.components
import qs.services

ShellRoot {
    Variants {
        model: Quickshell.screens

        Borders {
            required property var modelData

            screen: modelData
        }
    }

    CustomShortcut {
        name: "runner"
        description: "Toggle app runner"
        onPressed: {
            if (!RunnerState.visible)
                RunnerState.targetScreen = Hyprland.focusedMonitor?.name ?? "";
            RunnerState.visible = !RunnerState.visible;
        }
    }
}
