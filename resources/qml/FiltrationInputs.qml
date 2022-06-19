import QtQuick 2.12
import QtQuick.Controls 2.13

import "qrc:/resources/popup.js" as Popup

Rectangle {
    id: appField

    width: application.width / 2
    height: application.height - 60

    anchors {
        top: parent.top
        topMargin: 80
        left: parent.left
        leftMargin: 4
    }

    color: "#212031"

    CustomScrollView {
        padding: 0

        Item {
            width: 1
            height: 4
        }

        Rectangle {
            id: dateField

            property bool isChoosen: true

            width: application.width / 2 - 20
            height: beforeRect.height + afterRect.height + timeAndDateTitle.height + 24 + 12 + 12

            anchors {
                left: parent.left
                leftMargin: 4
            }

            color: isChoosen ? "#2b2a3e" : "#161620"
            radius: 8

            Rectangle {
                width: 16
                height: 16

                anchors {
                    top: parent.top
                    topMargin: 8
                    left: parent.left
                    leftMargin: 8
                }

                border.width: 1
                border.color: "black"
                radius: 8

                Image {
                    width: 12
                    height: 12

                    anchors.centerIn: parent

                    source: "qrc:/resources/images/Check.svg"
                    visible: dateField.isChoosen
                }

                MouseArea {
                    anchors.fill: parent

                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        dateField.isChoosen = !dateField.isChoosen
                    }
                }
            }

            CustomText {
                id: timeAndDateTitle

                anchors {
                    top: parent.top
                    topMargin: 12
                    horizontalCenter: parent.horizontalCenter
                }

                text: "Input time and date"
            }

            Item {
                id: beforeRect

                height: beforeTimeInput.height
                width: beforeRow.width

                anchors {
                    top: timeAndDateTitle.bottom
                    topMargin: 12
                    left: parent.left
                    leftMargin: 4
                }

                Row {
                    id: beforeRow

                    height: parent.height

                    spacing: 8

                    CustomText {
                        id: beforeTimeAndDateTitle

                        anchors.verticalCenter: parent.verticalCenter

                        text: "Before"
                    }

                    CustomInput {
                        id: beforeTimeInput

                        width: 130

                        anchors.verticalCenter: parent.verticalCenter

                        labelItem.text: "Time"
                        required: dateField.isChoosen
                        atomInput.validator: RegExpValidator { regExp: /([0-1][0-9]|2[0-3]):([0-5][0-9])/ }
                        atomInput.placeholderText: "08:00"
                    }

                    CustomCombobox {
                        id: beforeDayPicker

                        width: 130

                        model: {
                            var t = [...Array(32).keys()]
                            t.shift()
                            return t
                        }
                        atomTitle.title: "Day"
                    }

                    CustomCombobox {
                        id: beforeMonthPicker

                        width: 200

                        model: ["January", "February", "March", "April", "May", "June", "July",
                                "August", "September", "October", "November", "December"]
                        atomTitle.title: "Month"
                    }

                    CustomCombobox {
                        id: beforeYearPicker

                        width: 200

                        model: {
                            let years = []
                            let beginYear = 1950
                            let maxYear = 2026
                            for(var i=beginYear; i<maxYear; i++) {
                                years.push(i)
                            }
                            return years
                        }
                        atomTitle.title: "Year"
                        currentIndex: model.indexOf(2022)
                    }
                }
            }

            Item {
                width: 1
                height: 12
            }

            Item {
                id: afterRect

                height: afterTimeInput.height
                width: afterRow.width

                anchors {
                    top: beforeRect.bottom
                    topMargin: 12
                    left: parent.left
                    leftMargin: 4
                }

                Row {
                    id: afterRow

                    height: parent.height

                    spacing: 8

                    CustomText {
                        id: afterTimeAndDateTitle

                        anchors.verticalCenter: parent.verticalCenter

                        text: "After"
                    }

                    Item {
                        width: 13
                        height: 1
                    }

                    CustomInput {
                        id: afterTimeInput

                        width: 130

                        anchors.verticalCenter: parent.verticalCenter

                        labelItem.text: "Time"
                        atomInput.validator: RegExpValidator { regExp: /([0-1][0-9]|2[0-3]):([0-5][0-9])/ }
                        required: dateField.isChoosen
                        atomInput.placeholderText: "08:00"
                    }

                    CustomCombobox {
                        id: afterDayPicker

                        width: 130

                        model: {
                            var t = [...Array(32).keys()]
                            t.shift()
                            return t
                        }
                        atomTitle.title: "Day"
                    }

                    CustomCombobox {
                        id: afterMonthPicker

                        width: 200

                        model: ["January", "February", "March", "April", "May", "June", "July",
                                "August", "September", "October", "November", "December"]
                        atomTitle.title: "Month"
                    }

                    CustomCombobox {
                        id: afterYearPicker

                        width: 200

                        model: {
                            let years = []
                            let beginYear = 1950
                            let maxYear = 2026
                            for(var i=beginYear; i<maxYear; i++) {
                                years.push(i)
                            }
                            return years
                        }
                        atomTitle.title: "Year"
                        currentIndex: model.indexOf(2022)
                    }
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: hostNameField

                property bool isChoosen

                width: application.width / 4 - 13
                height: hostNameInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: hostNameField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            hostNameField.isChoosen = !hostNameField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: hostNameInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Host Name"
                    required: hostNameField.isChoosen
                }
            }

            Rectangle {
                id: macField

                property bool isChoosen

                width: application.width / 4 - 13
                height: macInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: macField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            macField.isChoosen = !macField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: macInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "MAC Address (MAC)"
                    required: macField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /([0-9A-Fa-f]{2}[:-]){13}([0-9A-Fa-f]{2})/ }
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: incomingInterfaceField

                property bool isChoosen

                width: application.width / 4 - 13
                height: incomingInterfaceInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: incomingInterfaceField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            incomingInterfaceField.isChoosen = !incomingInterfaceField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: incomingInterfaceInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Incoming Interface (IN)"
                    required: incomingInterfaceField.isChoosen
                }
            }

            Rectangle {
                id: outgoingInterfaceField

                property bool isChoosen

                width: application.width / 4 - 13
                height: outgoingInterfaceInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: outgoingInterfaceField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            outgoingInterfaceField.isChoosen = !outgoingInterfaceField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: outgoingInterfaceInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Outgoing Interface (OUT)"
                    required: outgoingInterfaceField.isChoosen
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: srcField

                property bool isChoosen

                width: application.width / 4 - 13
                height: srcInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: srcField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            srcField.isChoosen = !srcField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: srcInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Source IP (SRC)"
                    required: srcField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/ }
                }
            }

            Rectangle {
                id: dstField

                property bool isChoosen

                width: application.width / 4 - 13
                height: dstInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: dstField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            dstField.isChoosen = !dstField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: dstInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Destination IP (DST)"
                    required: dstField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/ }
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: minLengthField

                property bool isChoosen

                width: application.width / 4 - 13
                height: lengthMinInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: minLengthField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            minLengthField.isChoosen = !minLengthField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: lengthMinInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Minimum Length (LEN)"
                    required: minLengthField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(\d*)/ }
                }
            }

            Rectangle {
                id: maxLengthField

                property bool isChoosen

                width: application.width / 4 - 13
                height: lengthMinInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: maxLengthField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            maxLengthField.isChoosen = !maxLengthField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: lengthMaxInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Maximum Length (LEN)"
                    required: maxLengthField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(\d*)/ }
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: tosField

                property bool isChoosen

                width: application.width / 4 - 13
                height: tosInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: tosField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            tosField.isChoosen = !tosField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: tosInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Type of Service (TOS)"
                    required: tosField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(0x([a-fA-F0-9])*)/ }
                }
            }

            Rectangle {
                id: precField

                property bool isChoosen

                width: application.width / 4 - 13
                height: precInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: precField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            precField.isChoosen = !precField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: precInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Precedence (PREC)"
                    required: precField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(0x([a-fA-F0-9])*)/ }
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: ttlField

                property bool isChoosen

                width: application.width / 4 - 13
                height: ttlInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: ttlField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            ttlField.isChoosen = !ttlField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: ttlInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Time To Live (TTL)"
                    required: ttlField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(\d*)/ }
                }
            }

            Rectangle {
                id: idField

                property bool isChoosen

                width: application.width / 4 - 13
                height: idInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: idField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            idField.isChoosen = !idField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: idInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Unique ID (ID)"
                    required: idField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(\d*)/ }
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: ceField

                property bool isChoosen

                width: application.width / 4 - 13
                height: ceTitle.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: ceField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            ceField.isChoosen = !ceField.isChoosen
                        }
                    }
                }

                Text {
                    id: ceTitle

                    anchors.centerIn: parent

                    text: "Congestion Experienced Flag (CE)"
                    color: "#d4d2ff"
                    font.family: "Helvetica"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    elide: Text.ElideNone
                }
            }

            Rectangle {
                id: dfField

                property bool isChoosen

                width: application.width / 4 - 13
                height: dfTitle.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: dfField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            dfField.isChoosen = !dfField.isChoosen
                        }
                    }
                }

                Text {
                    id: dfTitle

                    anchors.centerIn: parent

                    text: "Don't Fragment Flag (DF)"
                    color: "#d4d2ff"
                    font.family: "Helvetica"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    elide: Text.ElideNone
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: mfField

                property bool isChoosen

                width: application.width / 4 - 13
                height: mfTitle.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: mfField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            mfField.isChoosen = !mfField.isChoosen
                        }
                    }
                }

                Text {
                    id: mfTitle

                    anchors.centerIn: parent

                    text: "More Fragments Flag (MF)"
                    color: "#d4d2ff"
                    font.family: "Helvetica"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.Wrap
                    elide: Text.ElideNone
                }
            }

            Rectangle {
                id: protoField

                property bool isChoosen

                width: application.width / 4 - 13
                height: protoInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: protoField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            protoField.isChoosen = !protoField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: protoInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Protocol (PROTO)"
                    required: protoField.isChoosen
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: sptField

                property bool isChoosen

                width: application.width / 4 - 13
                height: sptInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: sptField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            sptField.isChoosen = !sptField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: sptInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Source Port (SPT)"
                    required: sptField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /((6553[0-5])|(655[0-2][0-9])|(65[0-4][0-9]{2})|(6[0-4][0-9]{3})|([1-5][0-9]{4})|([0-5]{0,5})|([0-9]{1,4}))/ }
                }
            }

            Rectangle {
                id: dptField

                property bool isChoosen

                width: application.width / 4 - 13
                height: dptInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: dptField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            dptField.isChoosen = !dptField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: dptInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Destination Port (DPT)"
                    required: dptField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /((6553[0-5])|(655[0-2][0-9])|(65[0-4][0-9]{2})|(6[0-4][0-9]{3})|([1-5][0-9]{4})|([0-5]{0,5})|([0-9]{1,4}))/ }
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: seqField

                property bool isChoosen

                width: application.width / 4 - 13
                height: seqInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: seqField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            seqField.isChoosen = !seqField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: seqInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Receive Sequence number (SEQ)"
                    required: seqField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(\d*)/ }
                }
            }

            Rectangle {
                id: ackField

                property bool isChoosen

                width: application.width / 4 - 13
                height: ackInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: ackField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            ackField.isChoosen = !ackField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: ackInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "ACK"
                    required: ackField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(\d*)/ }
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: windowField

                property bool isChoosen

                width: application.width / 4 - 13
                height: windowInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: windowField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            windowField.isChoosen = !windowField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: windowInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "The TCP Receive Window size (WINDOW)"
                    required: windowField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(\d*)/ }
                }
            }

            Rectangle {
                id: resField

                property bool isChoosen

                width: application.width / 4 - 13
                height: resInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: resField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            resField.isChoosen = !resField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: resInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Reserved bits (RES)"
                    required: resField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(0x([a-fA-F0-9])*)/ }
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        Row {
            anchors {
                left: parent.left
                leftMargin: 4
            }

            spacing: 4

            Rectangle {
                id: packetFlagsField

                property bool isChoosen

                width: application.width / 4 - 13
                height: packetFlagsInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: packetFlagsField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            packetFlagsField.isChoosen = !packetFlagsField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: packetFlagsInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "Packet Flags (SYN URGP)"
                    required: packetFlagsField.isChoosen
                    atomInput.validator: RegExpValidator { regExp: /(\d*)/ }
                }
            }

            Rectangle {
                id: optField

                property bool isChoosen

                width: application.width / 4 - 13
                height: optInput.height + 24

                color: isChoosen ? "#2b2a3e" : "#161620"
                radius: 8

                Rectangle {
                    width: 16
                    height: 16

                    anchors {
                        top: parent.top
                        topMargin: 8
                        left: parent.left
                        leftMargin: 8
                    }

                    border.width: 1
                    border.color: "black"
                    radius: 8

                    Image {
                        width: 12
                        height: 12

                        anchors.centerIn: parent

                        source: "qrc:/resources/images/Check.svg"
                        visible: optField.isChoosen
                    }

                    MouseArea {
                        anchors.fill: parent

                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            optField.isChoosen = !optField.isChoosen
                        }
                    }
                }

                CustomInput {
                    id: optInput

                    width: parent.width - 60

                    anchors.centerIn: parent

                    labelItem.text: "TCP Options (OPT)"
                    required: optField.isChoosen
                }
            }
        }

        Item {
            width: 1
            height: 4
        }

        CustomButton {
            width: application.width / 2 - 20

            buttonText: "Filter logs"

            onClicked: {
                let rule = {}
                let error_text = ""
                if (dateField.isChoosen) {
                    if (!beforeTimeInput.atomInput.text.length) error_text += "Before time cannot be empty\n"
                    if (!afterTimeInput.atomInput.text.length) error_text += "After time cannot be empty\n"
                    rule["after_datetime"] = {}
                    rule["after_datetime"]["time"] = afterTimeInput.atomInput.text
                    rule["after_datetime"]["day"] = afterDayPicker.currentIndex + 1
                    rule["after_datetime"]["month"] = afterMonthPicker.currentIndex + 1
                    rule["after_datetime"]["year"] = afterYearPicker.model[afterYearPicker.currentIndex]

                    rule["before_datetime"] = {}
                    rule["before_datetime"]["time"] = beforeTimeInput.atomInput.text
                    rule["before_datetime"]["day"] = beforeDayPicker.currentIndex + 1
                    rule["before_datetime"]["month"] = beforeMonthPicker.currentIndex + 1
                    rule["before_datetime"]["year"] = beforeYearPicker.model[beforeYearPicker.currentIndex]
                }
                if (hostNameField.isChoosen) {
                    if (!hostNameInput.atomInput.text.length) error_text += "Host name cannot be empty\n"
                    rule["host_name"] = hostNameInput.atomInput.text
                }
                if (macField.isChoosen) {
                    if (!macInput.atomInput.text.length) error_text += "MAC address cannot be empty\n"
                    rule["mac"] = macInput.atomInput.text
                }
                if (incomingInterfaceField.isChoosen) {
                    if (!incomingInterfaceInput.atomInput.text.length) error_text += "Incoming interface cannot be empty\n"
                    rule["in"] = incomingInterfaceInput.atomInput.text
                }
                if (outgoingInterfaceField.isChoosen) {
                    if (!outgoingInterfaceInput.atomInput.text.length) error_text += "Outgoing interface cannot be empty\n"
                    rule["out"] = outgoingInterfaceInput.atomInput.text
                }
                if (srcField.isChoosen) {
                    if (!srcInput.atomInput.text.length) error_text += "Source IP cannot be empty\n"
                    rule["src"] = srcInput.atomInput.text
                }
                if (dstField.isChoosen) {
                    if (!dstInput.atomInput.text.length) error_text += "Destination IP cannot be empty\n"
                    rule["dst"] = dstInput.atomInput.text
                }
                if (minLengthField.isChoosen) {
                    if (!lengthMinInput.atomInput.text.length) error_text += "Minimum length cannot be empty\n"
                    rule["min_len"] = parseInt(lengthMinInput.atomInput.text)
                }
                if (maxLengthField.isChoosen) {
                    if (!lengthMaxInput.atomInput.text.length) error_text += "Maximum length cannot be empty\n"
                    rule["max_len"] = parseInt(lengthMaxInput.atomInput.text)
                }
                if (tosField.isChoosen) {
                if (!tosInput.atomInput.text.length) error_text += "Type Of Service cannot be empty\n"
                    rule["tos"] = tosInput.atomInput.text
                }
                if (precField.isChoosen) {
                    if (!precInput.atomInput.text.length) error_text += "Precedence cannot be empty\n"
                    rule["prec"] = precInput.atomInput.text
                }
                if (ttlField.isChoosen) {
                    if (!ttlInput.atomInput.text.length) error_text += "Time To Live cannot be empty\n"
                    rule["ttl"] = parseInt(ttlInput.atomInput.text)
                }
                if (idField.isChoosen) {
                    if (!idInput.atomInput.text.length) error_text += "ID cannot be empty\n"
                    rule["id"] = parseInt(idInput.atomInput.text)
                }
                if (ceField.isChoosen) {
                    rule["ce"] = ceField.isChoosen
                }
                if (dfField.isChoosen) {
                    rule["df"] = dfField.isChoosen
                }
                if (mfField.isChoosen) {
                    rule["mf"] = mfField.isChoosen
                }
                if (protoField.isChoosen) {
                    if (!protoInput.atomInput.text.length) error_text += "Protocol cannot be empty\n"
                    rule["proto"] = protoInput.atomInput.text
                }
                if (sptField.isChoosen) {
                    if (!sptInput.atomInput.text.length) error_text += "Source Port cannot be empty\n"
                    rule["spt"] = parseInt(sptInput.atomInput.text)
                }
                if (dptField.isChoosen) {
                    if (!dptInput.atomInput.text.length) error_text += "Destination Port cannot be empty\n"
                    rule["dpt"] = parseInt(dptInput.atomInput.text)
                }
                if (seqField.isChoosen) {
                    if (!seqInput.atomInput.text.length) error_text += "Receive Sequence number cannot be empty\n"
                    rule["seq"] = parseInt(seqInput.atomInput.text)
                }
                if (ackField.isChoosen) {
                    if (!ackInput.atomInput.text.length) error_text += "ACK cannot be empty\n"
                    rule["ack"] = ackInput.atomInput.text
                }
                if (windowField.isChoosen) {
                    if (!windowInput.atomInput.text.length) error_text += "The TCP Receive Window size cannot be empty\n"
                    rule["window"] = parseInt(windowInput.atomInput.text)
                }
                if (resField.isChoosen) {
                    if (!resInput.atomInput.text.length) error_text += "Reserved bits cannot be empty\n"
                    rule["res"] = resInput.atomInput.text
                }
                if (packetFlagsField.isChoosen) {
                    if (!packetFlagsInput.atomInput.text.length) error_text += "Packet Flags cannot be empty\n"
                    rule["packetFlags"] = packetFlagsInput.atomInput.text
                }
                if (optField.isChoosen) {
                    if (!optInput.atomInput.text.length) error_text += "TCP Options cannot be empty\n"
                    rule["opt"] = parseInt(optInput.atomInput.text)
                }
                if (error_text.length) {
                    Popup.create_popup("Error", error_text)
                    return
                }

                app.rule = rule
            }
        }

        Item {
            width: 1
            height: 24
        }
    }
}
