pragma ComponentBehavior: Bound

import "../../common"
import "../../services"
import "../../effects"
import "components"

import Quickshell
import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property var modelData
            screen: modelData

            anchors {
                left: true
                top: true
                bottom: true
            }

            color: "transparent"
            implicitWidth: Appearance.sidebarWidth

            Rectangle {
                anchors.fill: parent
                color: Colors.bg

                layer.enabled: true
                layer.samples: 2
                layer.effect: MistEffect {
                    uResolution: Qt.vector2d(root.width, root.height)
                }
            }

            ColumnLayout {
                spacing: 0
                anchors.fill: parent
                anchors.leftMargin: Appearance.overlayOffset

                Item {
                    Layout.preferredHeight: Appearance.overlayOffset
                }
                PanelButton {
                    Layout.fillWidth: true
                }
                /*
                ColumnLayout {
                    spacing: 0
                    anchors.left: parent.left
                    anchors.right: parent.right

                    Layout.alignment: Qt.AlignHCenter

                    Item {
                        Layout.preferredHeight: Appearance.componentOffset
                    }
                    TimeComponent {
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Item {
                        Layout.preferredHeight: Appearance.componentOffset
                    }
                    DateComponent {
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Item {
                        Layout.preferredHeight: Appearance.componentOffset
                    }
                    COutline {}
                }
                */
                DateTimeComponent {}

                Item {
                    Layout.fillHeight: true
                }
                TrayButton {
                    COutline {
                        canHover: true
                    }
                }
                AudioComponent {
                    Layout.fillWidth: true

                    COutline {}
                }
                BatteryComponent {
                    Layout.fillWidth: true

                    COutline {}
                }
                Item {
                    Layout.preferredHeight: Appearance.overlayOffset
                }
            }
        }
    }
}
