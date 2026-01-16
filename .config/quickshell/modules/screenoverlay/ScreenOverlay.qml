pragma ComponentBehavior: Bound

import "../../services"
import "../../effects"

import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import Quickshell

PanelWindow {
    id: root

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    implicitWidth: screen.width
    implicitHeight: screen.height

    color: "transparent"

    mask: Region {}

    Item {
        anchors.fill: parent
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowColor: "black"
            shadowOpacity: 1.0
            shadowBlur: 1.0
        }

        Shape {
            anchors.fill: parent

            layer.enabled: true
            layer.samples: 2
            layer.effect: MistEffect {
                uResolution: Qt.vector2d(root.width, root.height)
                uOffset: Qt.vector2d(Appearance.sidebarWidth, 0)
            }

            ShapePath {
                strokeWidth: -1
                startX: 0
                startY: 0

                // Start area
                PathLine {
                    x: root.width
                    y: 0
                }
                PathLine {
                    x: root.width
                    y: root.height
                }
                PathLine {
                    x: 0
                    y: root.height
                }
                PathLine {
                    x: 0
                    y: 0
                }

                // Cutout
                // Right Top
                PathMove {
                    x: root.width - Appearance.overlayRadius - Appearance.overlayOffset
                    y: Appearance.overlayOffset
                }
                PathArc {
                    x: root.width - Appearance.overlayOffset
                    y: Appearance.overlayRadius + Appearance.overlayOffset
                    radiusX: Appearance.overlayRadius
                    radiusY: Appearance.overlayRadius
                    direction: PathArc.Clockwise
                }

                // Right Bottom
                PathLine {
                    x: root.width - Appearance.overlayOffset
                    y: root.height - Appearance.overlayRadius - Appearance.overlayOffset
                }
                PathArc {
                    x: root.width - Appearance.overlayRadius - Appearance.overlayOffset
                    y: root.height - Appearance.overlayOffset
                    radiusX: Appearance.overlayRadius
                    radiusY: Appearance.overlayRadius
                    direction: PathArc.Clockwise
                }

                // Left Bottom
                PathLine {
                    x: Appearance.overlayRadius + Appearance.overlayOffset
                    y: root.height - Appearance.overlayOffset
                }
                PathArc {
                    x: Appearance.overlayOffset
                    y: root.height - Appearance.overlayRadius - Appearance.overlayOffset
                    radiusX: Appearance.overlayRadius
                    radiusY: Appearance.overlayRadius
                    direction: PathArc.Clockwise
                }

                // Left Top
                PathLine {
                    x: Appearance.overlayOffset
                    y: Appearance.overlayRadius + Appearance.overlayOffset
                }
                PathArc {
                    x: Appearance.overlayRadius + Appearance.overlayOffset
                    y: Appearance.overlayOffset
                    radiusX: Appearance.overlayRadius
                    radiusY: Appearance.overlayRadius
                    direction: PathArc.Clockwise
                }
            }
        }
    }
}
