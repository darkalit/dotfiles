import "../../../common"
import "../../../services"

import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts

RowLayout {
    Layout.fillWidth: true

    Item {
        Layout.fillWidth: true
        Layout.preferredHeight: 60

        COutline {
            anchors.fill: parent
        }

        Rectangle {
            anchors.fill: parent
            radius: Appearance.componentRadius
            color: Network.wifiEnabled ? Colors.accent : Colors.accentDim
            anchors.margins: 2
            opacity: 0.2
        }

        ColumnLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            spacing: -12
            RowLayout {
                spacing: 10
                Text {
                    text: {
                        if (!Network.active) {
                            return "󰤮 ";
                        }

                        let str = Math.floor(Network.active.strength);
                        if (str > 75) {
                            return "󰤨 ";
                        }
                        if (str > 50) {
                            return "󰤥 ";
                        }
                        if (str > 25) {
                            return "󰤢 ";
                        }
                        if (str > 0) {
                            return "󰤟 ";
                        }
                    }
                    color: Colors.fg

                    font.pixelSize: 16
                    font.bold: true
                }
                Text {
                    text: Network.active ? Network.active.ssid : "Network"
                    color: Colors.fg

                    font.pixelSize: 16
                    font.bold: true
                }
            }
            Text {
                text: Network.active?.active ? "Connected" : "Disconnected"
                color: Colors.fgDim

                font.pixelSize: 12
                font.bold: true
            }
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
            color: Bluetooth.defaultAdapter?.enabled ? Colors.accent : Colors.accentDim
            anchors.margins: 2
            opacity: 0.2
        }

        ColumnLayout {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            spacing: -12
            RowLayout {
                spacing: 10
                Text {
                    text: {
                        let adapter = Bluetooth.defaultAdapter;
                        if (!adapter)
                            return "󰂲";
                        switch (adapter.state) {
                        case BluetoothAdapterState.Disabled:
                            return "󰂲";
                        case BluetoothAdapterState.Enabling:
                        case BluetoothAdapterState.Disabling:
                            return "󰂱";
                        case BluetoothAdapterState.Enabled:
                            return "󰂯";
                        case BluetoothAdapterState.Blocked:
                            return "󰚛";
                        }
                    }
                    color: Colors.fg

                    font.pixelSize: 16
                    font.bold: true
                }

                Text {
                    text: "Bluetooth"
                    color: Colors.fg

                    font.pixelSize: 16
                    font.bold: true
                }
            }
        }
    }
}
