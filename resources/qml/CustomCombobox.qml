import QtQuick 2.12
import QtQuick.Controls 2.13
import QtGraphicalEffects 1.13


ComboBox {
    id: combobox

//  default text when current index is -1
    property var defaultText: "Not choosen"
//  child component
    property alias atomTitle: atomTitle
//  Use this for adding suffix
    property string suffix: ""

    height: contentItem.height

    model: []

    delegate: ItemDelegate {
        id: itemDelegate

        width: combobox.width
        height: 40

        Rectangle {
            anchors.fill: parent

            color: combobox.highlightedIndex == index ? "#2b2a3e" : "#3f3e5b"
        }

        contentItem: Text {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 16
            }

            text: suffix ? modelData + suffix : modelData
            color: "#d4d2ff"
            rightPadding: 30
        }

        Image {
            width: 16
            height: 16

            anchors {
                right: parent.right
                rightMargin: 16
                verticalCenter: parent.verticalCenter
            }

            visible: combobox.currentIndex == index
            source: "qrc:/resources/images/Shape.svg"
        }

        MouseArea {
            anchors.fill: parent

            enabled: true
            hoverEnabled: true
            cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

            acceptedButtons: Qt.NoButton
        }
    }

    indicator: Image {
        width: 16
        height: 16

        anchors {
            right: combobox.right
            rightMargin: 16
            verticalCenter: combobox.verticalCenter
        }

        source: "qrc:/resources/images/ActionDown.svg"
        rotation: popup.visible ? 180 : 0

        Behavior on rotation {
            NumberAnimation {
                duration: 200
            }
        }
    }

    contentItem: Item {
        height: atomTitle.height + 16

        anchors {
            left: parent.left
            right: indicator.left
            margins: 16
        }

        AtomTitle {
            id: atomTitle

            width: parent.width

            anchors.verticalCenter: parent.verticalCenter
            opacity: combobox.enabled ? 1 : 0.5
            subtitle: suffix ? combobox.displayText + suffix : combobox.displayText
        }
    }

    background: Rectangle {
        color: "#817fb7"
        radius: 4
    }

    popup: Popup {
        width: combobox.width
        height: popup.visible ? Math.min(contentItem.implicitHeight, 350) : 0

        padding: 0
        y: combobox.height - 8

        contentItem: CustomScrollView {
            padding: 0

            ListView {
                id: contentList

                width: parent.width
                implicitHeight: contentHeight

                clip: true
                spacing: 1
                model: combobox.popup.visible ? combobox.delegateModel : null
                currentIndex: combobox.highlightedIndex
                interactive: false
            }

            Rectangle {
                id: roundedMask

                width: bgRectangle.width
                height: bgRectangle.height

                visible: false
                radius: 12
                layer.enabled: true
            }

            layer.enabled: true
            layer.samplerName: "maskSource"
            layer.effect: ShaderEffect {
                property var colorSource: roundedMask
                property real contentWidth: popup.width
                property real contentHeight: popup.height

                fragmentShader: "
                    uniform lowp sampler2D colorSource;
                    uniform lowp sampler2D maskSource;
                    uniform lowp float contentWidth;
                    uniform lowp float contentHeight;
                    uniform lowp float qt_Opacity;
                    varying highp vec2 qt_TexCoord0;
                    const lowp float epsilon = 0.00001;
                    void main() {
                        if (
                            qt_TexCoord0.x < epsilon || qt_TexCoord0.x > 1.0 - epsilon
                            || qt_TexCoord0.y < epsilon || qt_TexCoord0.y > 1.0 - epsilon
                        ) {
                            gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
                        } else {
                            gl_FragColor =
                                texture2D(colorSource, qt_TexCoord0).a
                                * texture2D(maskSource, qt_TexCoord0)
                                * qt_Opacity;
                        }
                    }
                "
            }
        }

        background: Rectangle {
            id: bgRectangle

            color: "#2b2a3e"
            radius: 12

            DropShadow {
                anchors.fill: back

                verticalOffset: 1
                radius: parent.radius
                samples: 30
                color: "#b3000000"
                source: back
            }

            Rectangle {
                id: back

                anchors.fill: parent

                color: "#3f3e5b"
                radius: 12
            }
        }
    }

    MouseArea {
        anchors.fill: parent

        enabled: true
        hoverEnabled: true
        cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

        acceptedButtons: Qt.NoButton
    }
}