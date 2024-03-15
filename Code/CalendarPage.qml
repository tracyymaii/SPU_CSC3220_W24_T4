import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import "Database.js" as JS

ApplicationWindow {
    id: calendarPage
    width: 375
    height: 667
    visible: false
    color: "light blue"

    property date dateDisplay: new Date()

    ColumnLayout{
        Rectangle{
            id: toolBar
            width: calendarPage.width
            height: settingButton.height * 1.2
            color: calendarPage.color

            RowLayout{
                layoutDirection: Qt.RightToLeft
                anchors.right: parent.right
                anchors.bottom: parent.bottom

                CustomIconButton{
                    id: settingButton
                    appPage: calendarPage
                    dest: Setting{}
                    iconSource: "./assets/icons/settingIcon.png"
                }
            }

            CustomIconButton{
                id: homeButton
                appPage: calendarPage
                dest: homePage
                iconSource: "./assets/icons/homeIcon.png"
                anchors.left:parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 3
            }
        }

        Rectangle{
            id: heading
            width: calendarPage.width
            height: today.height * 1.2
            color: calendarPage.color

            anchors.topMargin: 8

            Text {
                id: today
                anchors.centerIn: parent
                text: Qt.formatDate(dateDisplay, "MM/yyyy")
                font.pointSize: 15
            }

           Button {
               id: prevButton
               text: "<-"
               flat: true
               font.pointSize: 15
               anchors.left:parent.left
               onClicked: {
                   dateDisplay = new Date(dateDisplay.getFullYear(),dateDisplay.getMonth() - 1,1)
               }
           }


           Button {
               id: nextMonth
               text: "->"
               flat: true
               font.pointSize: 15
               anchors.right:parent.right
               onClicked: {
                   dateDisplay = new Date(dateDisplay.getFullYear(),dateDisplay.getMonth() + 1,1)
               }
           }
        }

        Rectangle{
            id: calendar
            color: "white"
            width: calendarPage.width
            height: calendarPage.width

            ListView {
                id: listView
                width: calendarPage.width
                height: calendarPage.width

                orientation: ListView.Horizontal
                highlightRangeMode: ListView.StrictlyEnforceRange

                model: CalendarModel {
                    from: new Date(2024, 0, 1)
                    to: new Date(2025, 11, 31)
                }

                delegate: MonthGrid {
                    id: grid
                    width: calendarPage.width
                    height: calendarPage.width
                    year: model.year
                    month: dateDisplay.getMonth()
                    locale: Qt.locale("en_US")
                }

                DayOfWeekRow {
                    width: calendarPage.width
                    locale: Qt.locale("en_US")
                    Layout.fillWidth: true
                }
            }
        }

        Rectangle {
            id: petIcon
            width: calendarPage.width
            height: calendarPage.width
            color: "light blue"
            Image {
                id: pet
                source: "./assets/icons/catIcon.png"
                width: 60
                height: 50
                anchors.left: parent.left
            }

            Text {
                id: catTxt
                anchors.horizontalCenter: parent.horizontalCenter
                text: "\nYou're doing a great job!\n"
                font.pointSize: 15
            }
        }
    }
}