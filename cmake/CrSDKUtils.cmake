# The MIT License (MIT)
# Copyright (c) Kiyo Chinzei (kchinzei@gmail.com)
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

#[=======================================================================[.rst:
CrSDKUtils.cmake
-------

This Cmake module takes are of compiler and library settings to use  Sony Camera Remote SDK (CrSDK).
These settings are basically learned from the SDK's original CMakeLists.txt.

Usage
-------
These functions are loaded when `FIND_PACKAGE(CrSDK MODULE REQUIRED)` successful.

CrSDK_target_compile_setting(target)
Arrange compiler settings for `target`.

CrSDK_target_library_setting(target)
Copy SDK's binary library files to the appropriate location of the build.

Assumptions
------
- All files in the SDK located as original.
- Variable `CrSDK_LIBRARY_PATH` has been set by find_package().
- Target has been set by `add_executable()` etc. (You need to call CrSDK_target_compile_setting() after add_executable())

#]=======================================================================]

function(CrSDK_target_compile_setting tgt)

  if(APPLE)
    set(CMAKE_OSX_DEPLOYMENT_TARGET "10.14" CACHE STRING "Minimum OS X deployment version")
    set(CMAKE_APPLE_SILICON_PROCESSOR "x86_64" CACHE STRING "")
    set(CMAKE_OSX_ARCHITECTURES "x86_64")
  endif(APPLE)

  if(APPLE)
    set_target_properties(${tgt} PROPERTIES
      CXX_STANDARD 17
      CXX_STANDARD_REQUIRED YES
      CXX_EXTENSIONS NO
      BUILD_RPATH "@executable_path"
      )
  else(APPLE)
    set_target_properties(${tgt} PROPERTIES
      CXX_STANDARD 17
      CXX_STANDARD_REQUIRED YES
      CXX_EXTENSIONS NO
      BUILD_RPATH "$ORIGIN"
      INSTALL_RPATH "$ORIGIN"
      )
  endif(APPLE)

  ## Specify char is signed-char to fix mismatch with Raspbian
  target_compile_options(${tgt} PRIVATE -fsigned-char)

  if(WIN32)
    target_compile_definitions(${tgt} PRIVATE UNICODE _UNICODE)
  endif(WIN32)

  ### Linux specific configuration ###
  if(UNIX AND NOT APPLE)
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
      if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 8)
	# Must use std::experimental namespace if older than GCC8
	message("GCC version less than 8. Using std::experimental namespace.")
	target_compile_definitions(${tgt} PRIVATE USE_EXPERIMENTAL_FS)
      endif()
      if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 9)
	# Must explicitly link separate std::filesystem if older than GCC9
	message("GCC version less than 9. Explicitly linking separate std::filesystem library.")
	target_link_libraries(${tgt} PRIVATE stdc++fs)
      endif()
    endif()
  endif(UNIX AND NOT APPLE)

endfunction()


function(CrSDK_target_library_setting tgt)
  ## Library copy

  set(adaptor_dir_name "CrAdapter")

  if(APPLE)
    set(ct_fw "Contents/Frameworks")
    add_custom_command(TARGET ${tgt} PRE_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy "${CrSDK_LIBRARY}" "$<TARGET_FILE_DIR:${tgt}>"
      COMMAND ${CMAKE_COMMAND} -E copy_directory "${CrSDK_LIBRARY_PATH}/${adaptor_dir_name}" "$<TARGET_FILE_DIR:${tgt}>/${ct_fw}/${adaptor_dir_name}"
      )
  else(APPLE)
    add_custom_command(TARGET ${tgt} PRE_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy_directory "${CrSDK_LIBRARY_PATH}" "$<TARGET_FILE_DIR:${tgt}>"
      )
  endif(APPLE)

endfunction()
