import QtQuick 2.12
import QtQuick.Controls 2.13

import "qrc:/resources/popup.js" as Popup

Item {
    id: appField

    width: application.width / 2
    height: application.height - 50

    anchors {
        top: parent.top
        topMargin: 50
        left: parent.left
        leftMargin: 4
    }

    CustomScrollView {
        anchors {
            top: appField.top
            topMargin: 4
            left: appField.left
            leftMargin: 4
            right: appField.right
            rightMargin: 4
        }

        padding: 0

        Text {
            width: parent.width - 48

            text: app.analysis
            color: "#d4d2ff"
            font.family: "Helvetica"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            elide: Text.ElideNone
        }
    }
}