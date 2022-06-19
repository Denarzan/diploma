import QtQuick 2.13
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12


// Popup that contains cross button and any information placed inside column
Popup {
    id: popup

//  Header component
    property Component header: defaultHeaderComponent
//  Footer component
    property Component footer: defaultFooterComponent
//  Readonly header item
    readonly property alias headerItem: headerItem.item
//  Readonly footer item
    readonly property alias footerItem: footerItem.item
//  Components that should be placed inside content container
    default property alias content: contentContainer.data
//  Contant default policy for cases when you need to change from it and back
    readonly property var defaultPolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    property var title: "Error"

    width: 300

    anchors.centerIn: parent

    parent: ApplicationWindow.contentItem
    modal: true
    focus: true
    padding: 0
    closePolicy: defaultPolicy
    enter: Transition {
        NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 200 }
    }
    exit: Transition {
        NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 200 }
    }
    background: Rectangle {
        color: "#B3000000"
        width: application.width
        height: application.height
        x: 0 - parent.x
        y: 0 - parent.y
    }

    onClosed: {
        popup.destroy()
    }

    onOpened: {
        heightAnimation.enabled = true
    }

    Component.onCompleted: {
        // If popup height has not been initialized. Then set height based on the content
        if (height == 0) {
            contentView.height = Qt.binding(
                () => Math.min(contentView.contentHeight, 700 - footerItem.height - headerItem.height)
            )
            popupContainer.height = Qt.binding(() => headerItem.height + contentView.height + footerItem.height)
            height = Qt.binding(() => popupContainer.height)
        // Else set content height based on the popup height
        } else {
            contentView.height = Qt.binding(() => height - footerItem.height - headerItem.height)
        }
    }

    Component {
        id: defaultHeaderComponent

        Item {
            id: navBarModal

            width: parent.width
            height: 56

            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }

            // Fix performance problems. Use OpacityMask for background instead of top-level.
            Rectangle {
                anchors.fill: parent

                color: "#2b2a3e"
                // creates roundness for the upper corners
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: navBarModal.width
                        height: navBarModal.height

                        Rectangle {
                            anchors {
                                fill: parent
                                bottomMargin: -12
                            }

                            radius: 12
                        }
                    }
                }
            }

            CustomText {
                width: parent.width

                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 16
                    right: parent.right
                    rightMargin: 16
                }

                text: popup.title
            }

            CustomIcon {
                id: closeIcon

                anchors {
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 16
                }

                source: "qrc:/resources/images/Cross.svg"
                color: "#cc78ff"

                MouseArea {
                    anchors.fill: parent

                    enabled: true
                    hoverEnabled: true
                    cursorShape: enabled ? Qt.PointingHandCursor : Qt.ArrowCursor

                    onClicked: popup.close()
                }
            }
        }
    }

    Component {
        id: defaultFooterComponent

        Item {
            width: parent.width
            height: 24
        }
    }

    Rectangle {
        id: roundedMask

        width: popupContainer.width
        height: popupContainer.height

        visible: false
        radius: 12
        layer.enabled: true
    }

    contentItem: Rectangle {
        id: popupContainer

        width: parent.width
        height: headerItem.height + contentView.height + footerItem.height

        color: "#212031"
        clip: true
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
//                  Way to fix render issue
//                  if (sqrt(pow((qt_TexCoord0.x - 0.5) * contentWidth, 2.0)
//                      + pow((qt_TexCoord0.y - 0.5) * contentHeight, 2.0)) > radius) ...
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

        Behavior on height {
            id: heightAnimation

            enabled: false

            NumberAnimation {
                duration: 200
            }
        }

        Loader {
            id: headerItem

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }

            sourceComponent: header
            z: 2
        }

        CustomScrollView {
            id: contentView

            width: parent.width

            anchors {
                fill: undefined
                top: headerItem.bottom
            }

            padding: 0
            z: 1

            Column {
                id: contentContainer

                anchors {
                    left: parent.left
                    right: parent.right
                    margins: 24
                }
            }
        }

        Loader {
            id: footerItem

            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            sourceComponent: footer
            z: 2
        }

        Keys.onPressed: {
            if (!!enterOrReturnedPressedCallback && [Qt.Key_Return, Qt.Key_Enter].includes(event.key)) {
                enterOrReturnedPressedCallback()
            }
            else if (!!backspacePressedCallback && Qt.Key_Backspace == event.key) {
                backspacePressedCallback()
            }
        }
    }

    Component.onDestruction: {
        popup.close()
        modal = false
    }
}
