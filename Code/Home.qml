import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import "Database.js" as JS

ApplicationWindow {
    id: homePage

    width: 375
    height: 667
    visible: true
    color: "light blue"
    title: "App Name"

    ColumnLayout{
        Rectangle{
            id: toolBar

            width: homePage.width
            height: settingButton.height * 1.2
            color: homePage.color

            RowLayout{
                layoutDirection: Qt.RightToLeft
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                CustomIconButton{
                    id: settingButton
                    appPage: homePage
                    dest: Setting{}
                    iconSource: "./assets/icons/settingIcon.png"
                }
                CustomIconButton{
                    id: calendarButton
                    appPage: homePage
                    dest: CalendarPage{}
                    iconSource: "./assets/icons/calendarIcon.png"
                    Layout.alignment: Qt.AlignLeading
                }
            }
        }

        Rectangle{
            width: homePage.width
            height: happiness.height * 4
            color: homePage.color

            anchors.topMargin: 8

            HappinessBar{
                id: happiness
                value: happyRate
            }

            Rectangle{
                id: heartIcon
                width: parent.height * 0.8
                height: parent.height * 0.8
                color: parent.color
                anchors.horizontalCenter: parent.Center
                anchors.rightMargin: 5
                anchors.right: happiness.left

                Image {
                    width: parent.height
                    height: parent.height
                    source: "./assets/icons/heartIcon.png"
                }
            }
        }

        Rectangle{
            width: homePage.width
            height: homePage.width * 0.8
            color: homePage.color
            Image {
                id: pet
                source: "./assets/icons/catIcon.png"
                width: parent.height
                height: parent.height
                anchors.centerIn: parent
            }
        }

        Item {
            width: homePage.width
            height: todayAmount.height
            Rectangle{
                id: todayAmount
                width: waterTxt.width + waterIcon.width + 6
                height: waterTxt.height * 1.1
                radius: 10
                color: "light yellow"
                anchors.centerIn: parent
                Text {
                    id: waterTxt
                    text: qsTr("Today:  "+waterAmount+" L ")
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

        Rectangle{
            width: homePage.width
            height: waterButton.height
            color: homePage.color
            CustomButton{
                id: waterButton
                content: "Drink Water"
                anchors.centerIn: parent
                fontBold: true
                fontSize: 13
                onButtonClicked: {
                    homePage.visible = false
                    logPage.visible = true
                }
            }
        }
    }

    property string today: Qt.formatDateTime(new Date(), "MM/dd/yyyy")
    property real waterAmount
    property real happyRate

    Component.onCompleted: {
        JS.dbInit()
        JS.dbInsertDate(today)
        waterAmount = JS.dbReadAmount(today)
        happyRate = JS.dbReadHappiness(today)
    }

    Component{
        id: logPageComp
        WaterLog{}
    }

    property var logPage: logPageComp.createObject()
}
