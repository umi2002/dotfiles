pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

import qs.assets

Singleton {
    id: root

    readonly property var nodes: Pipewire.nodes.values.reduce((acc, node) => {
        if (!node.isStream) {
            if (node.isSink)
                acc.sinks.push(node);
            else if (node.audio)
                acc.sources.push(node);
        }
        return acc;
    }, {
        sources: [],
        sinks: []
    })
    readonly property list<PwNode> sinks: nodes.sinks
    readonly property list<PwNode> sources: nodes.sources
    readonly property PwNode defaultSink: sinks.find(sink => {
        return sink === Pipewire.defaultAudioSink;
    }) || null
    readonly property PwNode defaultSource: sources.find(source => {
        return source === Pipewire.defaultAudioSource;
    }) || null
    readonly property int volume: Math.round(defaultSink?.audio?.volume * 100)
    readonly property string volumeIcon: {
        if (defaultSink?.audio?.muted) {
            return Assets.volume.off;
        }

        if (volume > 60) {
            return Assets.volume.high;
        } else if (volume > 20) {
            return Assets.volume.medium;
        } else {
            return Assets.volume.low;
        }
    }

    PwObjectTracker {
        objects: [...root.sinks, ...root.sources]
    }

    function setVolume(volume) {
        setVolumeProcess.volume = volume;
        setVolumeProcess.running = true;
    }

    function toggleMute() {
        toggleMuteProcess.running = true;
    }

    Process {
        id: setVolumeProcess
        property int volume
        command: ["wpctl", "set-volume", "@DEFAULT_SINK@", volume.toString() + "%"]
    }

    Process {
        id: toggleMuteProcess
        command: ["wpctl", "set-mute", "@DEFAULT_SINK@", "toggle"]
    }
}
