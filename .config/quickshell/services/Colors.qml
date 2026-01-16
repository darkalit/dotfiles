pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property color bg: "#05080c"
    readonly property color surface: "#0e141b"
    readonly property color surfaceBright: "#18222e"

    readonly property color fg: "#f0f6fc"
    readonly property color fgDim: "#8b9eb5"
    readonly property color fgDark: "#3e4c5e"

    readonly property color accent: "#00a2ff"
    readonly property color accentDim: "#0056b3"

    readonly property color secondary: "#dcb15d"
    readonly property color tertiary: "#b0e0e6"

    readonly property color border: "#253345"
    readonly property color borderFocus: "#4da6ff"

    readonly property color error: "#dc143c"
    readonly property color success: "#50fa7b"
    readonly property color warning: "#f1c40f"
    readonly property color info: "#64b5f6"
}
