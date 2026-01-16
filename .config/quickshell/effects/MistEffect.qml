import "../services"

import QtQuick

ShaderEffect {
    required property vector2d uResolution
    property vector2d uOffset: Qt.vector2d(0, 0)

    property real time: ShaderUniforms.time

    property color uColorBg: Colors.bg
    property color uColorBlob: Colors.accent
    property color uColorShadow: Colors.border

    property real uZoom: Appearance.bgZoom
    property real uSpeed: Appearance.bgSpeed

    fragmentShader: "root:///shaders/mist.frag.qsb"
}
