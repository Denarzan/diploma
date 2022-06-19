import QtQuick 2.12
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.13

CustomPopup {
    id: popup
//  Text of the popup
    property alias description: descriptionText.text

    width: 500

    Item {
        width: 1
        height: 24
    }

    Text {
        id: descriptionText

        width: parent.width

        color: "#d4d2ff"
        font.family: "Helvetica"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        elide: Text.ElideNone
    }
}
