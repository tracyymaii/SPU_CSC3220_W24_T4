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
    property date dateSelected: dateDisplay

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
                    year: dateDisplay.getMonth()
                    month: dateDisplay.getMonth()
                    locale: Qt.locale("en_US")

                    onClicked: {
                    /*
                      Could not get this to work,
                      I'm not sure how to make the day clicked register and save as dateSelected.
                      */
                    //    dateSelected  = new Date(date, dateDisplay.getMonth(), 1)
                    }
                }

                DayOfWeekRow {
                    width: calendarPage.width
                    locale: Qt.locale("en_US")
                    Layout.fillWidth: true
                }
            }
        }

        Rectangle {
            id: waterInfo
            width: calendarPage.width
            height: calendarPage.height * 0.3
            color: "light blue"

            Text {
                id: infoTxt
                anchors.horizontalCenter: waterInfo.horizontalCenter
                font.pointSize: 11
                text: qsTr("You're doing great!\nSelect a day to find out how much water you drank!\nWater drank on "
                      + Qt.formatDate(dateDisplay, "MM/dd") + " :\n" + JS.dbReadAmount(dateDisplay) + "L")
                anchors.bottomMargin: 8
            }

            Image {
                id: pet
                source: "./assets/icons/catIcon.png"
                width: parent.height * 0.75
                height: parent.height * 0.75
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom

            }
        }
    }
}
