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

        Text {
            Layout.alignment: Qt.AlignLeft
            Layout.leftMargin: Appearance.componentOffset * 2
            Layout.preferredWidth: 20

            text: {
                let charBat = 0;
                let offset = Math.min(Math.floor(Brightness.value / 100 * 7), 6);
                charBat = 0xf00da + offset;
                return String.fromCodePoint(charBat);
            }
            color: Colors.fg

            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            font.features: {
                "tnum": 1
            }
        }

        CSlider {
            Layout.fillWidth: true

            thickness: 10

            value: Brightness.value / 100
            onMoved: {
                Brightness.value = Math.floor(this.value * 100);
            }
        }

        Text {
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: Appearance.componentOffset * 2
            Layout.preferredWidth: 42

            text: Brightness.value + "%"
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
