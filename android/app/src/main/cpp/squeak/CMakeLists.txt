# based on https://github.com/tom95/opensmalltalk-vm/blob/6f0dff503719bb8733e784f374dd6619d784f02c/meson.build

cmake_minimum_required(VERSION 3.22.1)

project("opensmalltalk-vm-cmake" LANGUAGES C)

if(NOT BUILD_AS_LIB)
  set(BUILD_AS_LIB 1)
endif()

if(NOT VM_KIND)
  set(VM_KIND COG)
endif()

set(VM_KIND_LIST STACK COG)
if(NOT (VM_KIND IN_LIST VM_KIND_LIST))
  message(FATAL_ERROR "VM_KIND must be one of ${VM_KIND_LIST}, but is set to '${VM_KIND}'")
endif()

if(BUILD_AS_LIB)
  message("Building squeak as shared library")
else()
  message("Building squeak as executeable")
endif()

set(SQUEAK_BASE_DIR "${CMAKE_CURRENT_LIST_DIR}/opensmalltalk-vm")
set(SQUEAK_UNIX_DIR "${SQUEAK_BASE_DIR}/platforms/unix")
set(SQUEAK_PLUGINS_DIR "${SQUEAK_BASE_DIR}/src/plugins")
set(SQUEAK_PLATFORM_PLUGINS_DIR "${SQUEAK_BASE_DIR}/platforms/Cross/plugins")
set(SQUEAK_GENERATED_DIR "${CMAKE_BINARY_DIR}/squeak-generated")
set(SQUEAK_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}/include")
string(TIMESTAMP SQUEAK_TIME "%Y-%m-%d %H:%M:%S")

set(SQUEAK_PLUGIN_SOURCES "")
set(SQUEAK_PLUGIN_INCLUDES "")
set(SQUEAK_PRIMS_HEAD "")
set(SQUEAK_PRIMS_TAIL "")

file(MAKE_DIRECTORY "${SQUEAK_GENERATED_DIR}")

macro(_add_files_to_list list files)
  set(_LIST "${files}")
  list(TRANSFORM _LIST PREPEND "${SQUEAK_BASE_DIR}/")
  list(APPEND ${list} ${_LIST})
endmacro()

macro(_add_plugin_prims name)
  string(APPEND SQUEAK_PRIMS_HEAD "extern sqExport ${name}_exports[]\;\n")
  string(APPEND SQUEAK_PRIMS_TAIL "\t${name}_exports,\n")
endmacro()

macro(add_plugin name)
  _add_plugin_prims(${name})

  set(PLUGIN_DIR "${SQUEAK_PLUGINS_DIR}/${name}")
  set(PLUGIN_PLATFORM_DIR "${SQUEAK_PLATFORM_PLUGINS_DIR}/${name}")
  set(PLUGIN_SRC "${PLUGIN_DIR}/${name}.c")
  # set(PLUGIN_SRC "${name}.c")

  if(EXISTS "${PLUGIN_SRC}")
    list(APPEND SQUEAK_PLUGIN_SOURCES "${PLUGIN_SRC}")
  endif()

  if(EXISTS "${PLUGIN_DIR}")
    list(APPEND SQUEAK_PLUGIN_INCLUDES "${PLUGIN_DIR}")
  endif()

  if(EXISTS "${PLUGIN_PLATFORM_DIR}")
    list(APPEND SQUEAK_PLUGIN_INCLUDES "${PLUGIN_PLATFORM_DIR}")
  endif()

  _add_files_to_list(SQUEAK_PLUGIN_SOURCES "${ARGN}")
endmacro()

macro(add_core_plugin name)
  _add_plugin_prims(${name})
endmacro()

macro(add_extra_sources)
  _add_files_to_list(SQUEAK_PLUGIN_SOURCES "${ARGN}")
endmacro()

macro(add_extra_includes)
  _add_files_to_list(SQUEAK_PLUGIN_INCLUDES "${ARGN}")
endmacro()

# Plugins

add_core_plugin("vm")
add_core_plugin("os")
add_plugin("ADPCMCodecPlugin")
add_plugin("AioPlugin")
add_plugin("AsynchFilePlugin"
  "platforms/unix/plugins/AsynchFilePlugin/sqUnixAsynchFile.c")
add_plugin("B2DPlugin")
add_plugin("BitBltPlugin")
add_plugin("BMPReadWriterPlugin")
add_plugin("CroquetPlugin"
  "platforms/Cross/plugins/CroquetPlugin/TriBoxStub.c")
add_plugin("HostWindowPlugin"
  "platforms/unix/plugins/HostWindowPlugin/sqUnixHostWindowPlugin.c")
add_plugin("ZipPlugin")
#add_plugin("DropPlugin"
#  "platforms/unix/plugins/DropPlugin/sqUnixDragDrop.c")
add_plugin("DSAPrims")
add_plugin("FFTPlugin")
add_plugin("FileCopyPlugin"
  "platforms/unix/plugins/FileCopyPlugin/sqUnixFileCopyPlugin.c")
add_plugin("FilePlugin"
  "platforms/Cross/plugins/FilePlugin/sqFilePluginBasicPrims.c"
  "platforms/unix/plugins/FilePlugin/sqUnixFile.c")
add_plugin("Float64ArrayPlugin")
add_plugin("FloatArrayPlugin")
add_plugin("FloatMathPlugin"
  "platforms/Cross/third-party/fdlibm/e_acos.c"
  "platforms/Cross/third-party/fdlibm/e_acos.c"
  "platforms/Cross/third-party/fdlibm/e_cosh.c"
  "platforms/Cross/third-party/fdlibm/e_sinh.c"
  "platforms/Cross/third-party/fdlibm/e_fmod.c"
  "platforms/Cross/third-party/fdlibm/e_sqrt.c"
  "platforms/Cross/third-party/fdlibm/e_log.c"
  "platforms/Cross/third-party/fdlibm/e_pow.c"
  "platforms/Cross/third-party/fdlibm/e_exp.c"
  "platforms/Cross/third-party/fdlibm/e_acosh.c"
  "platforms/Cross/third-party/fdlibm/e_log10.c"
  "platforms/Cross/third-party/fdlibm/e_atan2.c"
  "platforms/Cross/third-party/fdlibm/e_atanh.c"
  "platforms/Cross/third-party/fdlibm/e_log.c"
  "platforms/Cross/third-party/fdlibm/e_asin.c"
  "platforms/Cross/third-party/fdlibm/e_hypot.c")
add_plugin("IA32ABI"
  "platforms/Cross/plugins/IA32ABI/xabicc.c")
# add_plugin("JoystickTabletPlugin"
#   "platforms/unix/plugins/JoystickTabletPlugin/sqUnixJoystickTablet.c")
#add_plugin("JPEGReaderPlugin")
#add_plugin("JPEGReadWriter2Plugin"
#  "platforms/Cross/plugins/JPEGReadWriter2Plugin/sqJPEGReadWriter2Plugin.c"
#  "platforms/Cross/plugins/JPEGReadWriter2Plugin/jmemdatasrc.c")
add_plugin("Klatt")
add_plugin("LargeIntegers")
add_plugin("Matrix2x3Plugin")
add_plugin("MiscPrimitivePlugin")
add_plugin("Mpeg3Plugin"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/libmpeg3.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/bitstream.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/changesForSqueak.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/libmpeg3.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/mpeg3atrack.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/mpeg3demux.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/mpeg3io.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/mpeg3title.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/mpeg3vtrack.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/getpicture.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/headers.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/idct.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/macroblocks.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/mmxtest.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/motion.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/mpeg3video.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/output.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/reconstruct.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/seek.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/slice.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video/vlc.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio/dct.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio/header.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio/layer1.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio/layer2.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio/layer3.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio/mpeg3audio.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio/pcm.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio/synthesizers.c"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio/tables.c")
add_extra_includes(
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/audio"
  "platforms/Cross/plugins/Mpeg3Plugin/libmpeg/video")
add_plugin("RePlugin"
  "platforms/Cross/plugins/RePlugin/pcre.c"
  "platforms/Cross/plugins/RePlugin/study.c")
add_plugin("SecurityPlugin"
  "platforms/unix/plugins/SecurityPlugin/sqUnixSecurity.c")
add_plugin("SerialPlugin"
  "platforms/unix/plugins/SerialPlugin/sqUnixSerial.c")
add_plugin("SocketPlugin"
  "platforms/unix/plugins/SocketPlugin/sqUnixSocket.c")
add_plugin("SoundCodecPrims"
  "platforms/Cross/plugins/SoundCodecPrims/sqSoundCodecPluginBasicPrims.c")
add_plugin("SoundGenerationPlugin")
add_plugin("SoundPlugin"
  "platforms/unix/plugins/SoundPlugin/sqUnixSound.c")
add_plugin("StarSqueakPlugin")
add_plugin("SurfacePlugin"
  "platforms/Cross/plugins/SurfacePlugin/SurfacePlugin.c")
add_plugin("VMProfileLinuxSupportPlugin")
add_plugin("SqueakFFIPrims"
  "platforms/Cross/plugins/SqueakFFIPrims/sqFFIPlugin.c"
  "platforms/Cross/plugins/SqueakFFIPrims/sqManualSurface.c")
add_plugin("FileDialogPlugin" # TODO is this necessary?
  "platforms/unix/plugins/FileDialogPlugin/sqUnixFileDialog.c")

# Add Display and Sound plugins
add_extra_sources(
  # "platforms/unix/vm-display-X11/sqUnixX11.c"
  # "platforms/unix/vm-display-X11/sqUnixMozilla.c"
  "platforms/unix/vm-sound-null/sqUnixSoundNull.c"
  "platforms/unix/vm-display-null/sqUnixDisplayNull.c"
)
add_extra_includes(
  "platforms/unix/plugins/B3DAcceleratorPlugin"
  "platforms/Cross/plugins/B3DAcceleratorPlugin"
  "platforms/Cross/plugins/FilePlugin"
  ###
  "building/linux64x64/squeak.cog.spur/build" # ======= COG
  "platforms/Cross/vm"
  "platforms/Cross/plugins"
  "platforms/unix/vm"
#  "src/spur64.stack" # ======= STACK
#  "src/spur64.cog" # ======= COG
#  "processors/IA32/bochs/cpu"
)

if(VM_KIND STREQUAL STACK)
  add_extra_includes("src/spur64.stack")
elseif(VM_KIND STREQUAL COG)
  add_extra_includes("src/spur64.cog")
endif()

# VM sources
add_extra_sources(
  # Common
  "platforms/Cross/vm/sq.h"
  "platforms/Cross/vm/sqAssert.h"
  "platforms/Cross/vm/sqAtomicOps.h"
  "platforms/Cross/vm/sqCircularQueue.h"
#  "platforms/Cross/vm/sqCogStackAlignment.h" # ======= COG
  "platforms/Cross/vm/sqExternalSemaphores.c"
  "platforms/Cross/vm/sqHeapMap.c"
  "platforms/Cross/vm/sqMemoryAccess.h"
  "platforms/Cross/vm/sqMemoryFence.h"
  "platforms/Cross/vm/sqPath.h"
  "platforms/Cross/vm/sqNamedPrims.c"
  "platforms/Cross/vm/sqPath.c"
  "platforms/Cross/vm/sqSCCSVersion.h"
  "platforms/Cross/vm/sqTextEncoding.h"
  "platforms/Cross/vm/sqTextEncoding.c"
  "platforms/Cross/vm/sqTicker.c"
  "platforms/Cross/vm/sqVirtualMachine.h"
  "platforms/Cross/vm/sqVirtualMachine.c"
  # Platform
  "platforms/unix/vm/aio.c"
  "platforms/unix/vm/debug.c"
  "platforms/unix/vm/sqUnixCharConv.c"
  "platforms/unix/vm/sqUnixExternalPrims.c"
  "platforms/unix/vm/osExports.c"
  "platforms/unix/vm/sqUnixHeartbeat.c"
  "platforms/unix/vm/sqUnixMain.c"
  "platforms/unix/vm/sqUnixSpurMemory.c"
  "platforms/unix/vm/sqUnixThreads.c"
  "platforms/unix/vm/sqUnixVMProfile.c"
  "platforms/unix/vm/sqUnixDisplayHelpers.c"
  # Core
#  "src/spur64.stack/gcc3x-interp.c" # ======= STACK
#  "src/spur64.cog/gcc3x-cointerp.c" # ======= COG
#  "src/spur64.cog/cogit.c" # ======= COG
  # Generated
  "../include/version.c")

if(VM_KIND STREQUAL STACK)
  add_extra_sources("src/spur64.stack/gcc3x-interp.c")
elseif(VM_KIND STREQUAL COG)
  add_extra_sources(
    "platforms/Cross/vm/sqCogStackAlignment.h"
    "src/spur64.cog/gcc3x-cointerp.c"
    "src/spur64.cog/cogit.c")
endif()

# file(COPY_FILE "${SQUEAK_UNIX_DIR}/config/config.h.in" "${SQUEAK_GENERATED_DIR}/config.h")

set(SQUEAK_NAMED_PRIMS_H "${SQUEAK_GENERATED_DIR}/sqNamedPrims.h")
list(APPEND SQUEAK_PLUGIN_SOURCES "${SQUEAK_NAMED_PRIMS}")

string(CONCAT SQUEAK_PRIMS_STR
  "// Generated by CMake on ${SQUEAK_TIME}\n"
  ${SQUEAK_PRIMS_HEAD}
  "sqExport *pluginExports[] = {\n"
  ${SQUEAK_PRIMS_TAIL}
  "\tNULL\n};")

file(WRITE "${SQUEAK_NAMED_PRIMS_H}" "${SQUEAK_PRIMS_STR}")

set(SQUEAK_TARGET squeak)
if(BUILD_AS_LIB)
  add_library(${SQUEAK_TARGET} SHARED ${SQUEAK_PLUGIN_SOURCES})
else()
  add_executable(${SQUEAK_TARGET} ${SQUEAK_PLUGIN_SOURCES})
endif()

target_compile_definitions(${SQUEAK_TARGET} PRIVATE
  LSB_FIRST
  __USE_GNU
  _GNU_SOURCE
  HAVE_CONFIG_H
  # TODO: use only with actual builtins
  SQUEAK_BUILTIN_PLUGIN
  # BUILD_VM_CORE
  BIT_IDENTICAL_FLOATING_POINT
  NO_FFI_TEST
  DEBUGVM=0
  COGMTVM=0
  NOEXECINFO # TODO: consider removing this; prevents implicit backtrace() declaration in sqUnixMain.c
  BUILD_AS_LIB=${BUILD_AS_LIB}
)

# # FIXME sqAssert.h's assert is making use of those -- should find better fix
target_compile_options(${SQUEAK_TARGET} PRIVATE
  -Wno-unused-value
  -Wno-incompatible-function-pointer-types
  -Wno-incompatible-pointer-types
  -Wno-format-security
)

#find_package(OpenGL)
# find_package(X11)
#find_package(JPEG)

target_include_directories(${SQUEAK_TARGET} PRIVATE
  ${SQUEAK_GENERATED_DIR}
  ${SQUEAK_INCLUDE_DIR}
  ${SQUEAK_PLUGIN_INCLUDES}
  ${OPENGL_INCLUDE_DIR}
  # ${X11_INCLUDE_DIR}
#  ${JPEG_INCLUDE_DIRS}
)

target_link_libraries(${SQUEAK_TARGET} PRIVATE
  m
  dl
#  pthread
#  uuid
#  util
  z
#  OpenGL::GL
  # ${X11_LIBRARIES}
  # ${X11_Xrender_LIB}
#  JPEG::JPEG
)

  # add_library(${CMAKE_PROJECT_NAME} SHARED
  #     squeakxr_native.cpp)

  #target_link_libraries(${CMAKE_PROJECT_NAME}
	# List libraries link to the target library
	#android
	#log)

