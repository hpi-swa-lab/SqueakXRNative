cmake_minimum_required(VERSION 3.22.1)

project("squeakxrnative")

set(CMAKE_CXX_STANDARD 20)

set(ENABLE_RLOPENXR ON)
set(ENABLE_ANDROID ON)

include(../../../../../common/squeakxrnative.cmake)

# ==== opensmalltalk-vm ====

if(LOCAL_OPENSMALLTALKVM_SOURCE)
    set(FETCHCONTENT_SOURCE_DIR_OPENSMALLTALKVM "${LOCAL_OPENSMALLTALKVM_SOURCE}")
endif()

FetchContent_Declare(opensmalltalkvm
  GIT_REPOSITORY https://github.com/leogeier/opensmalltalk-vm.git
  GIT_TAG cmake-for-quest
)

FetchContent_MakeAvailable(opensmalltalkvm)

target_sources(${CMAKE_PROJECT_NAME} PRIVATE
  android.cpp
  squeak.cpp
  openxr_android.cpp
)
target_link_libraries(${CMAKE_PROJECT_NAME} android log squeak)
