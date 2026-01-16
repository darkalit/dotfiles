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
    spacing: Appearance.componentOffset

    Item {
        //Layout.fillWidth: true
        //Layout.preferredWidth: 120 + Appearance.componentOffset
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
            opacity: (Nightlight.isActive ? 0.5 : 0.2) - (nightmodeMA.containsMouse ? 0.1 : 0.0)
        }

        MouseArea {
            id: nightmodeMA
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                Nightlight.toggle();
            }
        }

        Text {
            anchors.fill: parent
            anchors.centerIn: parent
            text: "󰽧"
            color: Colors.fg

            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Item {
        Layout.fillWidth: true
        //Layout.preferredWidth: 120 + Appearance.componentOffset
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

        ColumnLayout {
            anchors.fill: parent
            spacing: 0
            RowLayout {
                Layout.topMargin: Appearance.componentOffset
                Layout.fillWidth: true
                Text {
                    Layout.fillWidth: true
                    text: "󰌪"
                    color: Colors.fg

                    font.pixelSize: 20
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    Layout.fillWidth: true
                    text: "󰗑 "
                    color: Colors.fg

                    font.pixelSize: 20
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                Text {
                    Layout.fillWidth: true
                    text: "󱐋 "
                    color: Colors.fg

                    font.pixelSize: 20
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            CSlider {
                Layout.bottomMargin: Appearance.componentOffset
                Layout.leftMargin: 50
                Layout.rightMargin: 50
                Layout.fillWidth: true

                thickness: 10
                snapMode: Slider.SnapAlways
                from: 0
                to: 2
                stepSize: 1

                value: Powermode.currentMode
                onMoved: {
                    Powermode.setMode(this.value);
                }
            }
        }
    }

    /*
    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 60

        COutline {
            anchors.fill: parent
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius
            color: {
                let mode = Powermode.currentMode;
                switch (mode) {
                case "power-saver":
                    return Colors.success;
                case "balanced":
                    return Colors.accent;
                case "performance":
                    return Colors.error;
                default:
                    break;
                }
            }
            anchors.margins: 2
            opacity: powermodeEcoMA.containsMouse ? 0.1 : 0.2
        }

        MouseArea {
            id: powermodeEcoMA
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                Powermode.cycle();
            }
        }

        Text {
            anchors.fill: parent
            anchors.centerIn: parent
            text: "󰌪"
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
            color: {
                let mode = Powermode.currentMode;
                switch (mode) {
                case "power-saver":
                    return Colors.success;
                case "balanced":
                    return Colors.accent;
                case "performance":
                    return Colors.error;
                default:
                    break;
                }
            }
            anchors.margins: 2
            opacity: powermodeBalMA.containsMouse ? 0.1 : 0.2
        }

        MouseArea {
            id: powermodeBalMA
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                Powermode.cycle();
            }
        }

        Text {
            anchors.fill: parent
            anchors.centerIn: parent
            text: "󰣳"
            color: Colors.fg

            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    Item {
        Layout.fillWidth: true
        //Layout.preferredWidth: 120 + Appearance.componentOffset
        Layout.preferredHeight: 60

        COutline {
            anchors.fill: parent
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius
            color: Colors.accent
            anchors.margins: 2
            opacity: powermodePerfMA.containsMouse ? 0.1 : 0.2
        }

        MouseArea {
            id: powermodePerfMA
            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                Audio.toggleMicMute();
            }
        }

        Text {
            anchors.fill: parent
            anchors.centerIn: parent
            text: "󱐋"
            color: Colors.fg

            font.pixelSize: 24
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    */
}
