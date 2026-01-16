import "components"
import "../../common"
import "../../services"
import "../../effects"

import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
    id: root
    property bool show: States.showPanel
    property vector2d offset: Qt.vector2d(Appearance.sidebarWidth + Appearance.windowGap, Appearance.windowGap)

    visible: menuContainer.opacity > 0
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        onClicked: States.showPanel = false
        cursorShape: Qt.ArrowCursor
    }

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    Rectangle {
        id: menuContainer
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: Appearance.windowGap
        anchors.topMargin: Appearance.windowGap
        //width: flow.implicitWidth + Appearance.overlayOffset * 2
        //height: flow.implicitHeight + Appearance.overlayOffset * 2
        width: 400
        height: root.screen.height - Appearance.windowGap * 2
        color: "transparent"

        opacity: root.show ? 1.0 : 0.0
        scale: root.show ? 1.0 : 0.95

        Behavior on opacity {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
            }
        }

        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutBack
            }
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius * 2
            opacity: menuContainer.opacity

            layer.enabled: true
            layer.samples: 2
            layer.effect: MistEffect {
                uResolution: Qt.vector2d(menuContainer.width, menuContainer.height)
                uOffset: root.offset
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
        }

        ColumnLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: Appearance.componentOffset
            spacing: Appearance.componentOffset

            NetworkingComponent {}

            QuickControlsComponent {}

            AudioControlComponent {}

            BrightnessComponent {}

            Item {
                Layout.fillWidth: true
                implicitHeight: resourceMonitor.implicitHeight + 15

                COutline {
                    anchors.fill: parent
                }

                Rectangle {
                    anchors.fill: parent
                    radius: Appearance.componentRadius
                    color: Colors.accent
                    anchors.margins: 2
                    opacity: 0.2
                }

                ResourceMonitorComponent {
                    id: resourceMonitor
                    anchors.centerIn: parent
                }
            }

            MixerNotifSwitcherComponent {}

            ReadAllButtonComponent {
                visible: States.showNotifications && Notifications.list.length > 0
            }

            VolumeMixerComponent {
                visible: States.showMixer
            }

            NotificationsComponent {
                visible: States.showNotifications
            }

            PowerMenuComponent {}
        }
    }
}
