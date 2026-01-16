pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int currentMode: 1
    readonly property list<string> powerModes: ["power-saver", "balanced", "performance"]

    function cycle() {
        setMode((currentMode++) % powerModes.length);
    }

    function setMode(mode: int) {
        currentMode = mode;
        procSetter.command = ["powerprofilesctl", "set", root.powerModes[mode]];
        procSetter.running = true;
    }

    Process {
        id: procStatus
        command: ["powerprofilesctl", "get"]

        stdout: SplitParser {
            onRead: data => {
                let d = data.trim();
                if (d !== "" && d !== root.powerModes[root.currentMode] && root.powerModes.indexOf(d) > -1) {
                    root.currentMode = root.powerModes.indexOf(d);
                }
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: procStatus.running = true
    }

    Process {
        id: procSetter
    }

    Component.onCompleted: procStatus.running = true
}
