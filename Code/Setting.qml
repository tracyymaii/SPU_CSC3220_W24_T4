import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.LocalStorage
import "Database.js" as JS


ApplicationWindow {
    id: settingPage

    width: 375
    height: 667
    visible: false
    color: "light blue"
    title: "App Name"

    property string newUName
    property string newPName


    ColumnLayout{
        Rectangle{
            id: toolBar
            width: settingPage.width
            height: settingButton.height * 1.2
            color: settingPage.color

            RowLayout {
                anchors.fill: parent
                anchors.bottom: parent.bottom

                CustomIconButton{
                    id: homeButton
                    appPage: settingPage
                    dest: homePage
                    iconSource: "./assets/icons/homeIcon.png"
                    Layout.alignment: Qt.AlignLeft
                }

                CustomIconButton{
                    id:calendarButton
                    appPage: settingPage
                    dest: calendarPage
                    iconSource: "./assets/icons/calendarIcon.png"
                    Layout.alignment: Qt.AlignRight
                }
            }
        }

        Rectangle{
            id: settingheader
            width: settingPage.width
            height: settingButton.height * 2
            color:  settingPage.color

            CustomButton {
                id: settingsWord
                content: qsTr("Settings")
                fontBold: true
                fontSize: 20
                anchors.centerIn: parent
            }
        }

        Rectangle{
            id: centerSection
            width: settingPage.width
            height: settingPage.width * 0.75
            color: settingPage.color

                Column{
                    spacing: 5
                    topPadding: 27
                    anchors.horizontalCenter: parent.horizontalCenter

                    CustomRectangleEditable{
                        id:settingspname
                        appPage: settingPage
                        contentLeft: "Pet Name"
                        contentRight: userData.pname
                        property alias newTextData: settingPage.newPName
                    }

                    CustomRectangleEditable{
                        id: settingsuname
                        appPage: settingPage
                        contentLeft: "Your Name"
                        contentRight: userData.uname
                        property alias newTextData: settingPage.newUName
                    }

                    CustomRectangle{
                        id:settingFaq
                        appPage: settingPage
                        contentLeft: "FAQ"
                    }

                    CustomRectangle{
                        id:settingPrivacy
                        appPage: settingPage
                        contentLeft: "Privacy"
                    }

                    CustomRectangle{
                        id:settingtandc
                        appPage: settingPage
                        contentLeft: "Terms and Conditions"
                    }

                    CustomRectangle{
                        id:settingnotifs
                        appPage: settingPage
                        contentLeft: "Notifications"

                        Rectangle {
                            color: "white"
                            width: settingPage.width * 0.35
                            height: settingPage.width * 0.09
                            radius: 8
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter

                                Switch{
                                    id:notifsSwitch
                                    anchors.right: parent.right
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.rightMargin: 5

                                }


                        }
                    }
                }
        }

        Column {
            Rectangle{
                id: bottomSection
                width: settingPage.width
                height: settingPage.width * 0.22
                color: settingPage.color

                CustomButton{
                    id: applyButton
                    content: "Apply Settings"
                    fontBold: true
                    fontSize: 13
                    anchors.horizontalCenter: parent.horizontalCenter

                    onButtonClicked: {
                        if (settingPage.newUName !== "" && settingPage.newPName !== "") {
                            errorMessage.visible = true
                            errorMessage.text = qsTr("Successfully updated user and pet name.")
                            JS.dbWriteUserInfo(0, settingPage.newUName, settingPage.newPName, 0)
                        } else {
                            console.log("Unable to perform DB write")
                            errorMessage.visible = true
                            errorMessage.text = qsTr("Unable to change user or pet name")
                        }
                    }
                }

                Text {
                    id: errorMessage
                    text: qsTr("Unable to change user or pet name")
                    visible: false
                    color: "red"
                    font.pointSize: 10
                    anchors.centerIn: parent
                  //  anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Rectangle{
                id: imageSection
                width: settingPage.width
                height: settingPage.width * 0.42
                color: settingPage.color

                Image {
                    id: pet
                    source: "./assets/icons/catIcon.png"
                    width: parent.height
                    height: parent.height
                    anchors.centerIn: parent
                }
            }
        }
    }

}
