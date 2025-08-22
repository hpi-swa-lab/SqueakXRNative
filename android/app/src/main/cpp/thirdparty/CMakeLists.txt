include(FetchContent)

# Adapted from https://github.com/Bigfoot71/raymob/blob/5606e6593083fb0ebb1525d8088de4c0156be674/app/src/main/cpp/deps/raylib/CMakeLists.txt

# ==== raylib ====

if(LOCAL_RAYLIB_SOURCE)
    set(FETCHCONTENT_SOURCE_DIR_RAYLIB "${LOCAL_RAYLIB_SOURCE}")
endif()

FetchContent_Declare(raylib
    GIT_REPOSITORY git@github.com:leogeier/raylib.git
    GIT_TAG squeakxr
    SOURCE_SUBDIR ignoreCmakeLists
)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

FetchContent_MakeAvailable(raylib)

set(RAYLIB_SOURCE_DIR "${raylib_SOURCE_DIR}/src")

add_library(raylib OBJECT
        ${RAYLIB_SOURCE_DIR}/rcore.c
        ${RAYLIB_SOURCE_DIR}/rmodels.c
        ${RAYLIB_SOURCE_DIR}/rshapes.c
        ${RAYLIB_SOURCE_DIR}/rtext.c
        ${RAYLIB_SOURCE_DIR}/rtextures.c
        ${RAYLIB_SOURCE_DIR}/raudio.c
        ${RAYLIB_SOURCE_DIR}/utils.c
        # Included by rcore.c
        #${SOURCE_DIR}/platforms/rcore_android.c
        ${ANDROID_NDK}/sources/android/native_app_glue/android_native_app_glue.c
)

set_property(TARGET raylib PROPERTY POSITION_INDEPENDENT_CODE ON)

# Include headers directory for android_native_app_glue.c
target_include_directories(raylib PRIVATE ${ANDROID_NDK}/sources/android/native_app_glue/)

target_include_directories(raylib INTERFACE ${RAYLIB_SOURCE_DIR})

# Add android_native_app_glue.c to the source files
#list(APPEND SOURCES ${ANDROID_NDK}/sources/android/native_app_glue/android_native_app_glue.c)

# Define compiler macros for raylib
target_compile_definitions(raylib PUBLIC PLATFORM_ANDROID __ANDROID__)

# Add specific compilation options based on target Android architecture
if(CMAKE_ANDROID_ARCH_ABI STREQUAL "armeabi-v7a")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfloat-abi=softfp -mfpu=vfpv3-d16")
elseif(CMAKE_ANDROID_ARCH_ABI STREQUAL "arm64-v8a")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mfix-cortex-a53-835769")
endif()

# Link required libraries to raylib
target_link_libraries(raylib log android EGL OpenSLES dl m c)

# Additional configuration depending on the desired OpenGL version
set(GL_VERSION "ES30")

if(GL_VERSION STREQUAL "ES20")
    message(WARNING "Using OpenGL ES 2.0, are you sure that this is right?")
    target_compile_definitions(raylib PUBLIC GRAPHICS_API_OPENGL_ES2)
    target_link_libraries(raylib GLESv2)
elseif(GL_VERSION STREQUAL "ES30" OR GL_VERSION STREQUAL "ES31" OR GL_VERSION STREQUAL "ES32")
    message("Using OpenGL ES 3.0")
    target_compile_definitions(raylib PUBLIC GRAPHICS_API_OPENGL_ES3)
    target_link_libraries(raylib GLESv3)
elseif(GL_VERSION)
    message(FATAL_ERROR "OpenGL version is defined to unhandled value: '${GL_VERSION}'")
else()
    message(FATAL_ERROR "OpenGL version is not defined")
endif()

# Add library-specific binding option
target_link_options(raylib PRIVATE "-u ANativeActivity_onCreate")

# ==== opensmalltalk-vm ====

if(LOCAL_OPENSMALLTALKVM_SOURCE)
    set(FETCHCONTENT_SOURCE_DIR_OPENSMALLTALKVM "${LOCAL_OPENSMALLTALKVM_SOURCE}")
endif()

FetchContent_Declare(opensmalltalkvm
  GIT_REPOSITORY git@github.com:leogeier/opensmalltalk-vm.git
  GIT_TAG cmake-for-quest
)

# ==== rlOpenXR ====

if(LOCAL_RLOPENXR_SOURCE)
    set(FETCHCONTENT_SOURCE_DIR_RLOPENXR "${LOCAL_RLOPENXR_SOURCE}")
endif()

FetchContent_Declare(rlOpenXR
        GIT_REPOSITORY git@github.com:leogeier/rlOpenXR.git# "${RLOPENXR_GIT_REPO}"
        GIT_TAG squeakxr
#        SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/rlOpenXR"
)

FetchContent_MakeAvailable(opensmalltalkvm rlOpenXR)
