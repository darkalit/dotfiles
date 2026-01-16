import "../../../common"
import "../../../services"
import "../../../effects"

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    height: layout.implicitHeight

    property Notification notification
    property vector2d offset: Qt.vector2d(Appearance.windowGap, Appearance.windowGap)

    Timer {
        id: decayTimer
        running: !ma.containsMouse
        interval: (root.notification.expireTimeout > 0) ? root.notification.expireTimeout : 5000
        onTriggered: {
            Notifications.removePopup(root.notification);
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: Appearance.componentRadius * 2

        layer.enabled: true
        layer.samples: 2
        layer.effect: MistEffect {
            uResolution: Qt.vector2d(root.width, root.height)
            uOffset: root.offset
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            let defaultAction = root.notification.actions.find(a => a.identifier === "default");
            if (defaultAction) {
                defaultAction.invoke();
            }
            Notifications.removePopup(root.notification);
        }
    }

    RowLayout {
        id: layout
        anchors.fill: parent
        spacing: 0

        Image {
            property real size: 32
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredWidth: size
            Layout.preferredHeight: size
            Layout.margins: 10
            visible: source
            sourceSize.width: size
            sourceSize.height: size
            source: {
                let icon = AppIconSearch.guessIcon(root.notification?.appIcon ?? "");
                if (!AppIconSearch.iconExists(icon)) {
                    return Quickshell.shellPath(icon);
                }
                return Quickshell.iconPath(icon);
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.topMargin: Appearance.componentOffset * 2
            Layout.bottomMargin: Appearance.componentOffset * 2
            spacing: 0

            Text {
                text: root.notification?.appName ?? ""
                color: Colors.fg
                font.pixelSize: 12
                font.bold: true
                Layout.fillWidth: true
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignLeft
                font.features: {
                    "tnum": 1
                }
            }

            Text {
                text: root.notification?.summary ?? ""
                color: Colors.fg
                font.pixelSize: 16
                font.bold: true
                Layout.fillWidth: true
                elide: Text.ElideRight
                horizontalAlignment: Text.AlignLeft
                font.features: {
                    "tnum": 1
                }
            }

            Text {
                text: root.notification?.body ?? ""
                color: Colors.fg
                font.pixelSize: 14
                font.bold: false
                Layout.fillWidth: true
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                maximumLineCount: 2
                horizontalAlignment: Text.AlignLeft
                font.features: {
                    "tnum": 1
                }
            }
        }
    }
}
