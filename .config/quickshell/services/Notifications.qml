pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    property var list: []
    //property var popupList: []
    property ListModel popupModel: ListModel {}
    readonly property NotificationServer server: NotificationServer {
        keepOnReload: true
        actionsSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        bodyMarkupSupported: true
        persistenceSupported: true
        imageSupported: true

        onNotification: notification => {
            notification.tracked = true;

            root.list = [notification, ...root.list];
            //root.popupList = [notification, ...root.popupList];
            root.popupModel.insert(0, {
                "notifData": notification
            });

            notification.closed.connect(() => {
                root.list = root.list.filter(n => n !== notification);
                removePopup(notification);
            });
        }
    }

    function dismissAll() {
        const toRemove = [...root.list];
        toRemove.forEach(notification => {
            notification.dismiss();
        });
    }

    function removePopup(notification) {
        //root.popupList = root.popupList.filter(n => n !== notification);
        for (let i = 0; i < root.popupModel.count; ++i) {
            if (root.popupModel.get(i).notifData === notification) {
                root.popupModel.remove(i);
                break;
            }
        }
    }
}
