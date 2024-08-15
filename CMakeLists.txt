cmake_minimum_required(VERSION 3.16)

project(qmlApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appqmlApp
    main.cpp
)

set(qml_singletons
    ThemeStyle.qml
)

set_source_files_properties(${qml_singletons}
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(appqmlApp
    URI qmlApp
    VERSION 1.0
    QML_FILES Main.qml
    QML_FILES CatalogNavi.qml
    QML_FILES ${qml_singletons}
    QML_FILES Home/MainPage.qml
    QML_FILES ListView/ListView1.qml ListView/ListView2.qml ListView/ListView3.qml ListView/MainPage.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appqmlApp PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appqmlApp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appqmlApp
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appqmlApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
