import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage

ApplicationWindow {
    id: logPage

    width: 375
    height: 667
    visible: false
    color: "light blue"
    title: "App Name"

    ColumnLayout{
        Rectangle{
            id: toolBar

            width: logPage.width
            height: settingButton.height * 1.2
            color: logPage.color

            RowLayout{
                layoutDirection: Qt.RightToLeft
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                CustomIconButton{
                    id: settingButton
                    appPage: logPage
                    dest: Setting{}
                    iconSource: "./assets/icons/settingIcon.png"
                }
                CustomIconButton{
                    id: calendarButton
                    appPage: logPage
                    dest: CalendarPage{}
                    iconSource: "./assets/icons/calendarIcon.png"
                    Layout.alignment: Qt.AlignLeading
                }
            }

            CustomIconButton{
                id: homeButton
                appPage: logPage
                dest: homePage
                iconSource: "./assets/icons/homeIcon.png"
                anchors.left:parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 3
            }
        }

        Rectangle{
            width: logPage.width
            height: dateTxt.height * 1.2
            color: logPage.color

            anchors.topMargin: 8

            Text {
                id: dateTxt
                anchors.centerIn: parent
                text: Qt.formatDateTime(new Date(), "MM/dd/yyyy")
                font.pointSize: 15
            }
        }

        Item {
            width: logPage.width
            height: todayAmount.height
            anchors.topMargin: 10
            Rectangle{
                id: todayAmount
                width: waterTxt.width + waterIcon.width + 6
                height: waterTxt.height * 1.1
                radius: 10
                color: "light yellow"
                anchors.centerIn: parent
                Text {
                    id: waterTxt
                    text: qsTr("Drank:  "+2+" L ")
                    font.pointSize: 13
                    anchors.right: parent.right
                    anchors.rightMargin: 2
                }
                Image {
                    id: waterIcon
                    source: "./assets/icons/waterIcon.png"
                    width: waterTxt.height
                    height: waterTxt.height
                    anchors.right: waterTxt.left
                    anchors.rightMargin: 2
                    anchors.leftMargin: 2
                }
            }
        }

        Rectangle {
            width: logPage.width
            height: message.height * 5
            color: logPage.color
            Text{
                id: message
                text: qsTr("Please Input Amount of Water")
                visible: false
                color: "red"
                font.pointSize: 10
                anchors.centerIn: parent
                anchors.bottom: parent.bottom
            }
        }

        Rectangle{
            id: txtBox
            y: 100
            width: logPage.width * 0.4
            height: 40
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            radius: 5

            TextInput {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                id: amountTxt
                font.pixelSize: 20
                font.bold: true
                width: container.width - 40
                color: "black"
                focus: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    amountTxt.selectAll();
                }
            }
        }

        CustomButton{
            id: addButton
            content: "Add"
            fontBold: true
            fontSize: 13
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            onButtonClicked: {
                if (amountTxt.text === "")
                    message.visible = true
                else{
                    message.visible = false
                }
            }
        }

    }
}
