cmake_minimum_required(VERSION 3.16)

project(WaterTracker VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appWaterTracker
    main.cpp
)

qt_add_qml_module(appWaterTracker
    URI WaterTracker
    VERSION 1.0
    QML_FILES Home.qml
    QML_FILES HappinessBar.qml
    QML_FILES CustomIconButton.qml
    QML_FILES CustomButton.qml
    QML_FILES WaterLog.qml
    QML_FILES Setting.qml
    QML_FILES CalendarPage.qml

    QML_FILES
    RESOURCES
    assets/icons/settingIcon.png
    assets/icons/calendarIcon.png
    assets/icons/heartIcon.png
    assets/icons/waterIcon.png
    assets/icons/homeIcon.png
    assets/icons/pencilIcon.svg
    assets/icons/plusIcon.svg
    assets/icons/catIcon.svg
    assets/icons/catIcon.png
    QML_FILES Database.js
    QML_FILES
    QML_FILES CustomRectangle.qml
    QML_FILES CustomRectangleEditable.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appWaterTracker PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appWaterTracker
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appWaterTracker
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appWaterTracker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
