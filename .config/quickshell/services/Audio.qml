pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import Caelestia.Services

import qs

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
    readonly property bool muted: defaultSink?.audio?.muted ?? false
    readonly property int volume: Math.round(defaultSink?.audio?.volume * 100)
    readonly property alias cava: cava
    readonly property int cavaBars: Config.cavaBars

    PwObjectTracker {
        objects: [...root.sinks, ...root.sources]
    }

    function setVolume(volume) {
        if (root.defaultSink?.audio)
            root.defaultSink.audio.volume = volume / 100;
    }

    function toggleMute() {
        if (root.defaultSink?.audio)
            root.defaultSink.audio.muted = !root.defaultSink.audio.muted;
    }

    CavaProvider {
        id: cava
        bars: root.cavaBars
    }
}
