import QtQuick 2.12
import QtQuick.Controls 2.13


Button {
    id: buttonRegular

    property var buttonText: "Text"

    width: parent.width
    height: 46

    opacity: enabled ? 1 : 0.6

    background: Rectangle {
        anchors.fill: parent

        radius: 8
        color: hovered ? "#cc78dd" : "#cc78ff"
        opacity: !enabled ? 0.3 : (pressed ? 0.6 : 1)
    }

    contentItem: CustomText {
        anchors.verticalCenter: parent.verticalCenter

        text: buttonRegular.buttonText
    }

    MouseArea {
        anchors.fill: parent

        enabled: true
        hoverEnabled: true
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

        onPressed: mouse.accepted = false
    }
}