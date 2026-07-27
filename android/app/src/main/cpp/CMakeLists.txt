cmake_minimum_required(VERSION 3.22.1)

project("squeakxrnative")

set(CMAKE_CXX_STANDARD 20)

set(ENABLE_RLOPENXR ON CACHE BOOL "Whether to compile with rlOpenXR")
set(ENABLE_ANDROID ON CACHE BOOL "Whether to compile for Android")

if(WIN32)
    foreach(config DEBUG RELEASE RELWITHDEBINFO MINSIZEREL)
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${config} ${CMAKE_BINARY_DIR})
    endforeach()
endif()

include(cmake/thirdparty.cmake)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

add_library(${CMAKE_PROJECT_NAME} SHARED
  text-rendering.cpp
  helpers.cpp
)

if(ENABLE_ANDROID)
  target_sources(${CMAKE_PROJECT_NAME} PRIVATE
    android.cpp
    squeak.cpp
  )
  target_link_libraries(${CMAKE_PROJECT_NAME} android log squeak)
endif()

if(ENABLE_RLOPENXR)
  message("ADD RLOPENXR")
  target_sources(${CMAKE_PROJECT_NAME} PRIVATE openxr.cpp)
  target_link_libraries(${CMAKE_PROJECT_NAME} rlOpenXR)
endif()

if(ENABLE_RLOPENXR AND ENABLE_ANDROID)
  target_sources(${CMAKE_PROJECT_NAME} PRIVATE openxr_android.cpp)
endif()

# Always linked
target_link_libraries(${CMAKE_PROJECT_NAME} raylib)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
