import "../../services"

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray

Button {
    id: root

    required property var modelData

    implicitWidth: Appearance.trayIconSize
    implicitHeight: Appearance.trayIconSize
    padding: 3

    background: Rectangle {
        color: root.hovered ? Colors.bg : Colors.surface
        radius: 8
    }

    contentItem: Image {
        source: root.modelData.icon
        fillMode: Image.PreserveAspectFit
    }

    /*
    QsMenuAnchor {
        id: menuAnchor
        anchor.item: icon
        anchor.edges: Edges.Left
        anchor.gravity: Edges.Right

        anchor.margins {
            left: 35
        }

        menu: root.modelData.menu
    }
    */

    onClicked: {
        //menuAnchor.open();
        /*
        if (mouse.button === Qt.RightButton) {
            // 2. Open the menu if it exists
            if (root.modelData.menu) {
                contextMenu.popup();
            }
        } else {
            root.modelData.activate();
        }
        */
        root.modelData.activate();
    }
}
