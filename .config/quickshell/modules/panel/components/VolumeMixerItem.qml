import "../../../services"
import "../../../common"

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    Layout.fillWidth: true
    Layout.preferredHeight: rootLayout.implicitHeight
    width: Appearance.panelWidth - Appearance.componentOffset * 2
    implicitHeight: rootLayout.implicitHeight

    required property PwNode node
    PwObjectTracker {
        objects: [root.node]
    }

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

    ColumnLayout {
        id: rootLayout
        anchors.fill: parent
        spacing: 0

        RowLayout {
            Layout.leftMargin: Appearance.componentOffset * 2
            Layout.rightMargin: Appearance.componentOffset * 2
            Layout.topMargin: Appearance.componentOffset * 2
            Image {
                property real size: 16
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                visible: source
                sourceSize.width: size
                sourceSize.height: size

                source: {
                    let icon = AppIconSearch.guessIcon(root.node?.properties["application.icon-name"] ?? "");
                    if (AppIconSearch.iconExists(icon)) {
                        return Quickshell.iconPath(icon);
                    }
                    icon = AppIconSearch.guessIcon(root.node?.properties["node.name"] ?? "");
                    if (AppIconSearch.iconExists(icon)) {
                        return Quickshell.iconPath(icon);
                    }
                    return Quickshell.shellPath(icon);
                }
            }

            Text {
                Layout.fillWidth: true
                text: {
                    const app = Audio.appNodeDisplayName(root.node);
                    const media = root.node.properties["media.name"];
                    return media != undefined ? `${app} - ${media}` : app;
                }
                maximumLineCount: 1
                elide: Text.ElideRight
                color: Colors.fg

                font.pixelSize: 16
                font.bold: true
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: Appearance.componentOffset * 2
            Layout.rightMargin: Appearance.componentOffset * 2
            Layout.bottomMargin: Appearance.componentOffset * 2
            CSlider {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter

                thickness: 10

                value: root.node.audio.volume
                onMoved: {
                    root.node.audio.volume = this.value;
                }
            }

            Text {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 42

                text: Math.round(root.node.audio.volume * 100) + "%"
                color: Colors.fg

                font.pixelSize: 16
                font.bold: true
                horizontalAlignment: Text.AlignRight
                font.features: {
                    "tnum": 1
                }
            }
        }
    }
}
