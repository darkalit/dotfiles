import "../../../services"

import Quickshell
import QtQuick

Text {
    id: root

    topPadding: Appearance.componentOffset
    bottomPadding: Appearance.componentOffset

    text: {
        let charBat = 0;
        let offset = Math.floor(Battery.percent / 10);
        if (offset > 1 && offset < 10) {
            charBat = 0xf007a + offset - 1;
        } else if (offset <= 1) {
            charBat = 0xf0083;
        } else if (offset === 10) {
            charBat = 0xf0079;
        }
        return String.fromCodePoint(charBat) + (Battery.isCharging ? "󱐋" : " ") + "\n" + Battery.percent;
    }

    color: Battery.isCharging ? Colors.accent : Colors.fg
    font.pixelSize: 12
    font.bold: true
    lineHeight: 0.8

    horizontalAlignment: Text.AlignHCenter
}
