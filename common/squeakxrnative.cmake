# Shared part of the squeakxrnative library. Included from the entry points in
# android/app/src/main/cpp and desktop, which set ENABLE_RLOPENXR and
# ENABLE_ANDROID before doing so.

include(${CMAKE_CURRENT_LIST_DIR}/cmake/thirdparty.cmake)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

add_library(${CMAKE_PROJECT_NAME} SHARED
  ${CMAKE_CURRENT_LIST_DIR}/src/text-rendering.cpp
  ${CMAKE_CURRENT_LIST_DIR}/src/helpers.cpp
)

if(ENABLE_RLOPENXR)
  message("ADD RLOPENXR")
  target_sources(${CMAKE_PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_LIST_DIR}/src/openxr.cpp)
  target_link_libraries(${CMAKE_PROJECT_NAME} rlOpenXR)
endif()

# Always linked
target_link_libraries(${CMAKE_PROJECT_NAME} raylib)
