import QtQuick 2.12
import QtQuick.Controls 2.13
import QtQuick.Window 2.13
import QtQuick.Dialogs 1.3

import "qrc:/resources/popup.js" as Popup


ApplicationWindow {
    id: application

    Connections {
        target: app

        onRuleChanged: {
            fileContent.text = !!app.rule ? app.filteredContent : app.fileContent
        }

        onDecryptError: {
            Popup.create_popup("Decryption error", "Seems like your file is not encrypted. Try to remove decryption checkbox.")
        }
    }

    width: 1600
    height: 800

    visible: true
    color: "#212031"
    title: "Security System Filter"

    minimumWidth: 1620
    minimumHeight: 600

    Item {
        id: navigationItem

        width: parent.width
        height: 50

        anchors.top: parent.top

        FileDialog {
            id: fileDialog

            title: "Choose log file"
            folder: shortcuts.home
            nameFilters: ["Text files (*.txt, *.log)"]

            onAccepted: {
                app.fileContent = fileDialog.fileUrl
                fileDialog.close()
            }

            onRejected: {
                fileDialog.close()
            }
        }

        CustomButton {
            id: analisysButton

            width: 150

            anchors {
                left: parent.left
                leftMargin: 4
                top: parent.top
                topMargin: 4
            }

            buttonText: filtrationLoader.visible ? "Filtration" : "Analysis"
            enabled: app.filePath.length > 0

            onClicked: {
                filtrationLoader.visible = !filtrationLoader.visible
                if (!filtrationLoader.visible) {
//                    app.analyze_file_by_name(app.filePath)
                }
            }
        }

        CustomButton {
            id: chooseFileButton

            width: 200

            anchors {
                left: analisysButton.right
                leftMargin: 4
                top: parent.top
                topMargin: 4
            }

            buttonText: "Choose log file"

            onClicked: {
                fileDialog.open()
            }
        }

        Rectangle {
            id: filePathRectangle

            width: parent.width - chooseFileButton.width - 40 - saveToFileButton.width - analisysButton.width
            height: filePath.height + 12

            anchors {
                top: parent.top
                topMargin: 12
                right: saveToFileButton.left
                rightMargin: 12
                left: chooseFileButton.right
                leftMargin: 12
            }

            color: "#2b2a3e"
            border.width: 1
            border.color: "black"
            radius: 8

            CustomText {
                id: filePath

                anchors {
                    verticalCenter: filePathRectangle.verticalCenter
                    left: filePathRectangle.left
                    leftMargin: 4
                    right: filePathRectangle.right
                    rightMargin: 4
                }

                text: app.filePath
            }
        }

        CustomButton {
            id: saveToFileButton

            width: 200

            anchors {
                right: parent.right
                rightMargin: 4
                top: parent.top
                topMargin: 4
            }

            buttonText: "Save logs"
            enabled: fileContent.text.length

            onClicked: {
                app.save_logs_to_file(fileContent.text)
                Popup.create_popup("Info", "Logs has been saved to 'filtered_logs.log' file")
            }
        }
    }

    Item {
        id: encryptItem

        width: 16 + encryptText.width
        height: encryptText.height

        anchors {
            top: parent.top
            topMargin: 56
            left: parent.left
            leftMargin: 12
        }

        Rectangle {
            id: encryptCheckBox

            width: 16
            height: 16

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
            }

            border.width: 1
            border.color: "black"
            radius: 8

            Image {
                width: 12
                height: 12

                anchors.centerIn: parent

                source: "qrc:/resources/images/Check.svg"
                visible: app.encrypt
            }

            MouseArea {
                anchors.fill: parent

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    app.encrypt = !app.encrypt
                }
            }
        }

        Text {
            id: encryptText

            anchors {
                verticalCenter: parent.verticalCenter
                left: encryptCheckBox.right
                leftMargin: 4
            }

            text: "Encrypt"
            color: "#d4d2ff"
            font.family: "Helvetica"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            elide: Text.ElideNone
        }
    }

    Item {
        width: 16 + decryptText.width
        height: decryptText.height

        anchors {
            top: parent.top
            topMargin: 56
            left: encryptItem.right
            leftMargin: 12
        }

        Rectangle {
            id: decryptCheckBox

            width: 16
            height: 16

            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
            }

            border.width: 1
            border.color: "black"
            radius: 8

            Image {
                width: 12
                height: 12

                anchors.centerIn: parent

                source: "qrc:/resources/images/Check.svg"
                visible: app.decrypt
            }

            MouseArea {
                anchors.fill: parent

                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    app.decrypt = !app.decrypt
                }
            }
        }

        Text {
            id: decryptText

            anchors {
                verticalCenter: parent.verticalCenter
                left: decryptCheckBox.right
                leftMargin: 4
            }

            text: "Decrypt"
            color: "#d4d2ff"
            font.family: "Helvetica"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            elide: Text.ElideNone
        }
    }

    Rectangle {
        id: textField

        width: application.width / 2
        height: application.height - 50

        anchors {
            top: parent.top
            topMargin: 50
            right: parent.right
            rightMargin: 4
        }

        color: "#212031"

        CustomScrollView {
            anchors {
                top: textField.top
                topMargin: 4
                left: textField.left
                leftMargin: 4
                right: textField.right
                rightMargin: 4
            }

            padding: 0

            Text {
                id: fileContent

                width: parent.width

                text: !!app.rule ? app.filteredContent : app.fileContent
                color: "#d4d2ff"
                font.family: "Helvetica"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
                elide: Text.ElideNone
            }
        }
    }


    Loader {
        id: filtrationLoader

        source: "qrc:/resources/qml/FiltrationInputs.qml"
    }

    Loader {
        id: analysisLoader

        source: "qrc:/resources/qml/Analysis.qml"
        visible: !filtrationLoader.visible
    }
}
