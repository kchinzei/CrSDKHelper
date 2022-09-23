#
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
FindCrSDK.cmake
-------

This Cmake module helps finding where Sony Camera Remote SDK (CrSDK) is installed.

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following imported targets, if found:

  CrSDK directory and its contents
  include files
  link binaries
  other external files

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``CrSDK_FOUND``
  True if the system has CrSDK.
``CrSDK_ROOT_DIR``
  The root directory. Cached.

Advanced Variables
^^^^^^^^^^^^^^^^^^

Other advanced variable are also set. 

``CrSDK_INCLUDE_FILES`` # Minimal required include files, CameraRemote_SDK.h
``CrSDK_INCLUDE_PATH``  # Parent directory of CameraRemote_SDK.h
``CrSDK_LIBRARIES``     # Minimal required lib to link, *Cr_Core.*
``CrSDK_LIBRARY_PATH``  # Parent directory of *Cr_Core.*
``CrSDK_SAMPLE_SOURCE_PATH`` # Parent directory of sample souce files
``CrSDK_VERSION_MAJOR`` # Version number of CrSDK_Readme_*.pdf
``CrSDK_VERSION_MINOR`` # Version number of CrSDK_Readme_*.pdf
``CrSDK_VERSION_PATCH`` # Version number of CrSDK_Readme_*.pdf

Cache Variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``CrSDK_ROOT_DIR``

CMakeLists.txt Snippet
~~~~~~~~~~~~~~~~~~~~~

Typical CMakeLists.txt snippet is;

 FIND_PACKAGE(CrSDK MODULE REQUIRED)
 IF(CrSDK_FOUND)
   LINK_DIRECTORIES(${CrSDK_LIBRARY_PATH})
   ADD_EXECUTABLE(${your_app} ${your_srcs})
   TARGET_INCLUDE_DIRECTORIES(${your_app} PRIVATE ${CrSDK_INCLUDE_PATH})
   TARGET_LINK_LIBRARIES(${your_app} ${your_libs} ${CrSDK_LIBRARIES})
   CrSDK_target_compile_setting(${your_app})
   CrSDK_target_library_setting(${your_app})
 ENDIF(CrSDK_FOUND)

You can include all necessary include files by;

  #include "CameraRemote_SDK.h"

#]=======================================================================]

cmake_minimum_required(VERSION 3.20) # cmake_path() needs 3.20

set(__sdk_root_dir CrSDK_v1)
set(__include_file CameraRemote_SDK.h)
set(__include_path app/CRSDK)
set(__src_path app/CRSDK)
set(__lib_file Cr_Core libCr_Core)
set(__lib_path external/crsdk)
set(__readme_stem CrSDK_Readme_v)

if(CrSDK_ROOT_DIR)
  set(CrSDK_root_tmp "${CrSDK_ROOT_DIR}")
else(CrSDK_ROOT_DIR)
  set(CrSDK_root_tmp "${CMAKE_CURRENT_LIST_DIR}/../${__sdk_root_dir}")
endif(CrSDK_ROOT_DIR)

unset(CrSDK_ROOT_DIR)

find_path(CrSDK_ROOT_DIR
  NAMES ${__include_path}/${__include_file}
  PATHS "${CrSDK_root_tmp}"
  REQUIRED
  )
find_path(CrSDK_INCLUDE_PATH
  NAMES ${__include_file}
  PATHS "${CrSDK_ROOT_DIR}/${__include_path}"
  NO_CACHE
  NO_DEFAULT_PATH
  REQUIRED
  )
find_library(CrSDK_LIBRARY
  NAMES ${__lib_file}
  PATHS "${CrSDK_ROOT_DIR}/${__lib_path}"
  NO_CACHE
  NO_DEFAULT_PATH
  REQUIRED
  )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CrSDK
  DEFAULT_MSG
  CrSDK_LIBRARY
  CrSDK_INCLUDE_PATH
  )

if(CrSDK_FOUND)
  set(CrSDK_INCLUDE_FILES "${__include_file}")
  set(CrSDK_SOURCE_FILES "")

  set(CrSDK_LIBRARIES "${CrSDK_LIBRARY}")
  cmake_path(GET CrSDK_LIBRARY PARENT_PATH CrSDK_LIBRARY_PATH)
  cmake_path(SET CrSDK_SAMPLE_SOURCE_PATH NORMALIZE "${CrSDK_INCLUDE_PATH}/..")
  set(CrSDK_DEFINITIONS ${CrSDK_CFLAGS_OTHER})
    
  set(CrSDK_VERSION_MAJOR 1)
  set(CrSDK_VERSION_MINOR 0)
  set(CrSDK_VERSION_PATCH 5)

  # Get version info from readme.
  file(GLOB __readme
    LIST_DIRECTORIES FALSE
    RELATIVE "${CrSDK_ROOT_DIR}"
    "${CrSDK_ROOT_DIR}/${__readme_stem}*"
    )
  if(__readme)
    if(${__readme} MATCHES "${__readme_stem}([0-9]*)\\.([0-9]*)\\.([0-9]*)")
      set(CrSDK_VERSION_MAJOR ${CMAKE_MATCH_1})
      set(CrSDK_VERSION_MINOR ${CMAKE_MATCH_2})
      set(CrSDK_VERSION_PATCH ${CMAKE_MATCH_3})
    endif()
  endif(__readme)

  # Include util for you.
  include("${CMAKE_CURRENT_LIST_DIR}/CrSDKUtils.cmake")

  # It should be in CrSDKUtil.cmake, but experiments reveal it's necessary to be called before add_executable().
  if(APPLE)
    set(CMAKE_OSX_ARCHITECTURES "x86_64")
  endif(APPLE)
  
endif(CrSDK_FOUND)

unset(CrSDK_INCLUDE_PATH CACHE)
unset(CrSDK_LIBRARY CACHE)

