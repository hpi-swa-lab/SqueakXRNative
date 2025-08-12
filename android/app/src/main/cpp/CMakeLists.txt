cmake_minimum_required(VERSION 3.22.1)

project("squeakxrnative")

add_subdirectory(thirdparty)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
add_library(${CMAKE_PROJECT_NAME} SHARED
        native-lib.cpp
)

target_link_libraries(${CMAKE_PROJECT_NAME}
        android
        log
        squeak
        raylib
        rlOpenXR
)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
