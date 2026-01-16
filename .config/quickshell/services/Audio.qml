pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    property bool ready: Pipewire.defaultAudioSink?.ready ?? false
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    property real value: sink?.audio.volume ?? 0

    PwObjectTracker {
        objects: [root.sink, root.source]
    }

    function friendlyDeviceName(node) {
        return (node?.nickname || node?.description || "Unknown");
    }
    function appNodeDisplayName(node) {
        return (node?.properties["application.name"] || node?.description || node?.name);
    }

    function correctType(node, isSink) {
        return (node.isSink === isSink) && node.audio;
    }
    function appNodes(isSink) {
        return Pipewire.nodes.values.filter(node => { // Should be list<PwNode> but it breaks ScriptModel
            return root.correctType(node, isSink) && node.isStream;
        });
    }
    function devices(isSink) {
        return Pipewire.nodes.values.filter(node => {
            return root.correctType(node, isSink) && !node.isStream;
        });
    }
    readonly property list<var> outputAppNodes: root.appNodes(true)
    readonly property list<var> inputAppNodes: root.appNodes(false)
    readonly property list<var> outputDevices: root.devices(true)
    readonly property list<var> inputDevices: root.devices(false)

    function toggleMute() {
        Audio.sink.audio.muted = !Audio.sink.audio.muted;
    }

    function toggleMicMute() {
        Audio.source.audio.muted = !Audio.source.audio.muted;
    }

    function incrementVolume() {
        const currentVolume = Audio.value;
        const step = currentVolume < 0.1 ? 0.01 : 0.02 || 0.2;
        Audio.sink.audio.volume = Math.min(1, Audio.sink.audio.volume + step);
    }

    function decrementVolume() {
        const currentVolume = Audio.value;
        const step = currentVolume < 0.1 ? 0.01 : 0.02 || 0.2;
        Audio.sink.audio.volume -= step;
    }

    function setDefaultSink(node) {
        Pipewire.preferredDefaultAudioSink = node;
    }

    function setDefaultSource(node) {
        Pipewire.preferredDefaultAudioSource = node;
    }
}
