import "../../../services"
import "../../../common"

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

RowLayout {
    id: root
    Layout.fillWidth: true

    Item {
        Layout.preferredWidth: 60
        Layout.preferredHeight: 60

        COutline {
            anchors.fill: parent
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius
            color: Colors.accent
            anchors.margins: 2
            opacity: micMA.containsMouse ? 0.1 : 0.2
        }

        MouseArea {
            id: micMA
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                Audio.toggleMicMute();
            }
        }

        Text {
            anchors.fill: parent
            anchors.centerIn: parent
            text: Audio.source.audio.muted ? "󰍭" : "󰍬"
            color: Colors.fg

            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Item {
        Layout.preferredWidth: 60
        Layout.preferredHeight: 60

        COutline {
            anchors.fill: parent
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius
            color: Colors.accent
            anchors.margins: 2
            opacity: outMA.containsMouse ? 0.1 : 0.2
        }

        MouseArea {
            id: outMA
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                Audio.toggleMute();
            }
        }

        Text {
            anchors.fill: parent
            anchors.centerIn: parent
            text: {
                let audio = Audio.sink.audio;
                let volume = Math.floor(audio.volume * 100.0);
                if (audio.muted)
                    return "";
                else if (volume >= 50)
                    return "";
                else if (volume > 0)
                    return "";
                else
                    return "";
            }
            color: Colors.fg

            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 60

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

        RowLayout {
            anchors.fill: parent
            anchors.centerIn: parent

            CSlider {
                Layout.leftMargin: Appearance.componentOffset * 2
                Layout.fillWidth: true

                thickness: 10

                value: Audio.sink.audio.volume
                onMoved: {
                    Audio.sink.audio.volume = this.value;
                }
            }

            Text {
                Layout.rightMargin: Appearance.componentOffset * 2
                Layout.preferredWidth: 42

                text: Math.floor(Audio.sink.audio.volume * 100.0) + "%"
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
