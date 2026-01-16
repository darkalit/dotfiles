pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property bool isActive: false

    function toggle() {
        procToggle.running = true;
    }

    Process {
        id: procStatus
        command: ["pgrep", "-x", "gammastep"]

        stdout: StdioCollector {
            onStreamFinished: root.isActive = (this.text.trim() !== "")
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: procStatus.running = true
    }

    Process {
        id: procToggle
        command: ["sh", "-c", "~/.local/bin/toggle-gammastep"]
        onExited: (exitCode, exitStatus) => procStatus.running = true
    }

    Component.onCompleted: procStatus.running = true
}
