pragma ComponentBehavior: Bound

import "../../services"

import QtQuick
import QtQuick.Layouts
import Quickshell

Scope {
    id: root
    property bool failed
    property string errorString

    // Connect to the Quickshell global to listen for the reload signals.
    Connections {
        target: Quickshell

        function onReloadCompleted() {
            Quickshell.inhibitReloadPopup();
            root.failed = false;
            root.errorString = "";
            popup.visible = true;
        //popupLoader.loading = true;
        }

        function onReloadFailed(error: string) {
            Quickshell.inhibitReloadPopup();
            //popupLoader.active = true;

            root.failed = true;
            root.errorString = error;
            popup.visible = true;
        //popupLoader.loading = true;
        }
    }

    PanelWindow {
        id: popup

        anchors {
            top: true
            left: true
        }
        implicitWidth: rect.width
        implicitHeight: rect.height

        color: "transparent"

        Rectangle {
            id: rect
            color: root.failed ? Colors.error : Colors.success

            implicitHeight: layout.implicitHeight + 50
            implicitWidth: layout.implicitWidth + 30

            // Fills the whole area of the rectangle, making any clicks go to it,
            // which dismiss the popup.
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: popup.visible = false

                // makes the mouse area track mouse hovering, so the hide animation
                // can be paused when hovering.
                hoverEnabled: true
            }

            ColumnLayout {
                id: layout
                anchors {
                    top: parent.top
                    topMargin: 20
                    horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: root.failed ? "Reload failed." : "Reloaded completed!"
                    color: Colors.fgDark
                }

                Text {
                    text: root.errorString
                    color: Colors.fgDark
                    visible: root.errorString != ""
                }
            }

            Rectangle {
                id: bar
                color: Colors.accent
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                height: 20

                PropertyAnimation {
                    id: anim
                    target: bar
                    property: "width"
                    from: rect.width
                    to: 0
                    duration: root.failed ? 10000 : 1000
                    onFinished: popup.visible = false

                    paused: mouseArea.containsMouse
                }
            }

            Component.onCompleted: anim.start()
        }
    }
}
