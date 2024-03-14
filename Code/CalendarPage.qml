import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage

ApplicationWindow {
    id: calendarPage
    width: 375
    height: 667
    visible: false
    color: "light blue"

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
            height: monthTxt.height * 1.2
            color: calendarPage.color

            anchors.topMargin: 8

            Text {
                id: monthTxt
                anchors.centerIn: parent
                text: Qt.formatDate(new Date(), "MM/yyyy")
                font.pointSize: 15
            }

           Button {
               id: prevButton
               text: "<-"
               flat: true
               font.pointSize: 15
               anchors.left:parent.left
           }


           Button {
               id: nextMonth
               text: "->"
               flat: true
               font.pointSize: 15
               anchors.right:parent.right
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
                    month: Calendar.March
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
