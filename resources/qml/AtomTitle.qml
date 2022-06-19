import QtQuick 2.12
import QtQuick.Controls 2.13


Item {
    id: atomTitle

//  Upper text
    property alias title: titleItem.text
//  Bottom text
    property alias subtitle: subtitleItem.text
//  Whether need to change Text
    property alias subtitleItem: subtitleItem
//  Whether need to read
    property alias titleItem: titleItem
//  Elide long Title or Subtitle text
    property alias elide: titleItem.elide

    implicitWidth: 100
    height: Math.max(30, textBlock.height)

    Column {
        id: textBlock

        width: parent.width

        anchors.verticalCenter: parent.verticalCenter


        CustomText {
            id: titleItem

            width: parent.width
            height: visible ? contentHeight : 0

            lineHeight: 16
            font.pixelSize: 12
            horizontalAlignment: Text.AlignLeft
        }

        CustomText {
            id: subtitleItem

            width: textBlock.width

            visible: !!text
            elide: titleItem.elide
            font.pixelSize: 16
        }
    }
}
