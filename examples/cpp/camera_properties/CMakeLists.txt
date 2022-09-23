
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

cmake_minimum_required(VERSION 3.20)

set(app camera_properties)
set(c_srcs camera_properties.cpp)
project(${app})

# Find the Sony SDK
if(CrSDK_ROOT_DIR)
  list(APPEND CMAKE_MODULE_PATH "${CrSDK_ROOT_DIR}/../cmake")
endif(CrSDK_ROOT_DIR)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../../cmake")
find_package(CrSDK MODULE REQUIRED)

if(CrSDK_FOUND)
  add_executable(${app} ${c_srcs} ${CrSDK_INCLUDE_FILES} ${CrSDK_SOURCE_FILES})
  target_include_directories(${app} PRIVATE ${CrSDK_INCLUDE_PATH})
  target_link_libraries(${app} ${CrSDK_LIBRARIES})

  CrSDK_target_compile_setting(${app})
  CrSDK_target_library_setting(${app})
endif(CrSDK_FOUND)
