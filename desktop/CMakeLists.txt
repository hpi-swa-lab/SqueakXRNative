cmake_minimum_required(VERSION 3.22.1)

project("squeakxrnative")

set(CMAKE_CXX_STANDARD 20)

set(ENABLE_RLOPENXR ON CACHE BOOL "Whether to compile with rlOpenXR")
set(ENABLE_ANDROID OFF)

if(WIN32)
    foreach(config DEBUG RELEASE RELWITHDEBINFO MINSIZEREL)
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${config} ${CMAKE_BINARY_DIR})
    endforeach()
endif()

include(../common/squeakxrnative.cmake)

set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
