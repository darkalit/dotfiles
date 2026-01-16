import "../../../services"
import "../../../common"

import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: root
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter
    implicitHeight: layout.height

    COutline {
        canHover: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: States.toggleCalendar()
    }

    ColumnLayout {
        id: layout
        spacing: 5
        anchors.centerIn: parent

        Text {
            Layout.topMargin: 5
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatDateTime(Time.time, "hh\nmm\nAP")

            color: Colors.fg
            font.pixelSize: 16
            font.bold: true
            lineHeight: 0.8

            horizontalAlignment: Text.AlignHCenter
            font.features: {
                "tnum": 1
            }
        }

        Text {
            Layout.bottomMargin: 5
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            text: Qt.formatDateTime(Time.time, "MM\n󰿟\ndd\n󰿟\nyy")

            color: Colors.fg
            font.pixelSize: 16
            font.bold: true
            lineHeight: 0.6

            horizontalAlignment: Text.AlignHCenter
            font.features: {
                "tnum": 1
            }
        }
    }
}
