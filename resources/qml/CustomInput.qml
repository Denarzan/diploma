import QtQuick 2.12
import QtQuick.Controls 2.13


Rectangle {
//  Main input
    property alias atomInput: atomInput
//  Label
    property alias labelItem: labelItem
//  If bad input
    readonly property bool isValid: !commentError.text
//  Validator error
    property var validatorError: ""
//  Length error
    property var lengthError: ""
//  Regex to validate the content on focus lost. Do not use with `atomInput.validator` property
    property var regex
//  Apply field validation ONLY when field has not active focus
    property bool hasValidationOnFocusLost: false
//  Comment error element
    property alias errorText: commentError.text
    property bool required: true

    function checkValid() {
        if (!!regex) atomInput.validator.regExp = regex
        if (!atomInput.text.trim() && required) {
            commentError.text = "Can't me empty"
        } else if (!atomInput.acceptableInput && required) {
            commentError.text = validatorError.length ? validatorError : "Incorrent value"
        } else if (atomInput.text.length > atomInput.maximumLength) {
            commentError.text = lengthError ? lengthError : "Incorrent value"
        } else {
            commentError.text = ""
        }
        if (hasValidationOnFocusLost) atomInput.validator.regExp = /.*/
        return isValid
    }

    Component.onCompleted: atomInput.text = atomInput.text // to cancel property binding

    onRegexChanged: atomInput.validator.regExp = regex

    width: parent.width
    height: column.height + 16

    color: atomInput.activeFocus ? "#3f3e5b" : "#817fb7"
    radius: 4

    Column {
        id: column

        width: parent.width

        spacing: 4

        anchors {
            top: parent.top
            topMargin: 8
            left: parent.left
            right: parent.right
            leftMargin: 16
            rightMargin: 16
        }

        TextField {
            id: atomInput

            width: parent.width
            height: contentHeight + labelItem.height

            color: "#d4d2ff"
            placeholderTextColor: "#9F9F9F"
            font.pixelSize: 16
            font.family: "Helvetica"
            bottomPadding: 0
            topPadding: 0
            leftPadding: 0
            rightPadding: 2
            selectByMouse: true
            selectionColor: "#333333"
            verticalAlignment: labelItem.visible ? TextInput.AlignBottom : TextInput.AlignVCenter
            cursorDelegate: Rectangle {
                width: 2
                height: 24

                visible: parent.cursorVisible
                color: "#333333"

                onVisibleChanged: {
                    if (visible) {
                        opacity = 1
                        timer.start()
                    }
                    else timer.stop()
                }

                Timer {
                    id: timer

                    interval: 700
                    running: true
                    repeat: true

                    onTriggered: parent.opacity = !parent.opacity ? 1 : 0
                }

                Connections {
                    target: parent

                    onCursorPositionChanged: {
                        opacity = 1
                        timer.restart()
                    }
                }
            }
            background: Item {}

            validator: RegExpValidator {
                regExp: regex ? regex : /.*/
            }

            onTextEdited: commentError.text = ""

            onActiveFocusChanged:
            {
                if (hasValidationOnFocusLost && regex) validator.regExp = activeFocus ? /.*/ : regex
                if (!activeFocus) {
                    checkValid()
                    ensureVisible(0)
                }
            }
        }

        Rectangle {
            id: underLine

            height: 1

            anchors {
                right: atomInput.right
                left: atomInput.left
            }

            color: {
                if (isValid) {
                    if (!atomInput.activeFocus) "#c7c7c7"
                    return "787878"
                }
                return "#ff7c7c"
            }
        }

        Text {
            id: commentError

            anchors {
                left: atomInput.left
                right: atomInput.right
            }

            visible: !!text
            color: "#ff7c7c"
        }
    }

    CustomText {
        id: labelItem

        width: parent.width
        height: visible ? contentHeight : 0

        anchors {
            top: parent.top
            topMargin: 8
            left: parent.left
            leftMargin: 12
        }

        lineHeight: 16
        font.pixelSize: 12
        horizontalAlignment: Text.AlignLeft
    }
}
