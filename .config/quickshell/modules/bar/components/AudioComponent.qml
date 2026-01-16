import "../../../services"

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    color: "transparent"

    ColumnLayout {
        id: layout
        spacing: 0
        anchors.centerIn: parent

        Item {
            Layout.preferredHeight: Appearance.componentOffset
        }
        Text {
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
            font.pixelSize: 12

            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: Audio.source.audio.muted ? "󰍭" : "󰍬"
            color: Colors.fg
            font.pixelSize: 16

            Layout.alignment: Qt.AlignHCenter
        }
        Item {
            Layout.preferredHeight: Appearance.componentOffset
        }
    }
}
