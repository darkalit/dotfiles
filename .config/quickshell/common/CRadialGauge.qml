import "../services"

import QtQuick
import QtQuick.Layouts

Item {
    id: root

    required property real value
    required property string label
    required property string subLabel

    property real thickness: 5

    onValueChanged: canvas.requestPaint()

    ColumnLayout {
        anchors.centerIn: parent
        anchors.top: parent.verticalCenter
        anchors.topMargin: root.thickness / 2 + Appearance.componentOffset
        spacing: 0

        Text {
            Layout.alignment: Qt.AlignHCenter

            text: root.label
            color: Colors.fg

            font.pixelSize: 20
            font.bold: true
        }

        Text {
            Layout.alignment: Qt.AlignHCenter

            text: root.subLabel
            color: Colors.fgDim

            font.pixelSize: 12
        }
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        readonly property real centerX: width / 2
        readonly property real centerY: height / 2

        readonly property real arcStart: degToRad(135)
        readonly property real arcEnd: degToRad(405)

        function degToRad(deg: int): real {
            return deg * Math.PI / 180;
        }

        onPaint: {
            const ctx = getContext("2d");
            ctx.reset();

            ctx.lineWidth = root.thickness;
            ctx.lineCap = "round";

            const radius = (Math.min(width, height) - ctx.lineWidth) / 2;

            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, arcStart, arcEnd, false);
            ctx.strokeStyle = Colors.surface;
            ctx.stroke();

            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, arcStart, (arcEnd - arcStart) * root.value + arcStart, false);
            ctx.strokeStyle = Colors.accent;
            ctx.stroke();
        }
    }
}
