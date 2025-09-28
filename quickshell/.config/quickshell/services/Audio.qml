pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

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
            return "../assets/volume_off_icon.svg";
        }

        if (volume > 60) {
            return "../assets/volume_high_icon.svg";
        } else if (volume > 20) {
            return "../assets/volume_medium_icon.svg";
        } else {
            return "../assets/volume_low_icon.svg";
        }
    }

    PwObjectTracker {
        objects: [...root.sinks, ...root.sources]
    }

    function setVolume(volume) {
        console.log(volume);
        setVolumeProcess.volume = volume;
        setVolumeProcess.running = true;
    }

    Process {
        id: setVolumeProcess
        property int volume
        command: ["wpctl", "set-volume", "@DEFAULT_SINK@", volume.toString() + "%"]
    }
}
