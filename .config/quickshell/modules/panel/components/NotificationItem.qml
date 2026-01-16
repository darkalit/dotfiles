import "../../../services"
import "../../../common"

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    Layout.fillWidth: true
    Layout.preferredHeight: rootLayout.implicitHeight
    width: Appearance.panelWidth - Appearance.componentOffset * 2
    implicitHeight: rootLayout.implicitHeight

    property Notification notification

    COutline {
        anchors.fill: parent
    }

    Rectangle {
        anchors.fill: parent
        radius: Appearance.componentRadius
        color: Colors.accent
        anchors.margins: 2
        opacity: ma.containsMouse ? 0.1 : 0.2
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: mouse => {
            switch (mouse.button) {
            case Qt.RightButton:
                root.notification.dismiss();
                break;
            case Qt.LeftButton:
                let defaultAction = root.notification.actions.find(a => a.identifier === "default");
                if (defaultAction) {
                    defaultAction.invoke();
                } else {
                    root.notification.dismiss();
                }
                break;
            default:
                return;
            }
        }
    }

    RowLayout {
        id: rootLayout
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
                maximumLineCount: 5
                horizontalAlignment: Text.AlignLeft
                font.features: {
                    "tnum": 1
                }
            }
        }
    }
}
