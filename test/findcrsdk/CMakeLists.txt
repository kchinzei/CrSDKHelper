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

# This file is to test if cmake can find necessary files.
# It's not to compile anything.

cmake_minimum_required(VERSION 3.20)
project(Test)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../cmake")
find_package(CrSDK MODULE REQUIRED)

message("CrSDK_FOUND = ${CrSDK_FOUND}")
if(CrSDK_FOUND)
  message("CrSDK_ROOT_DIR      = ${CrSDK_ROOT_DIR}")
  message("CrSDK_INCLUDE_PATH  = ${CrSDK_INCLUDE_PATH}")
  message("CrSDK_INCLUDE_FILES = ${CrSDK_INCLUDE_FILES}")
  message("CrSDK_SOURCE_FILES  = ${CrSDK_SOURCE_FILES}")
  message("CrSDK_LIBRARY_PATH  = ${CrSDK_LIBRARY_PATH}") 
  message("CrSDK_LIBRARY       = ${CrSDK_LIBRARY}") 
  message("CrSDK_LIBRARIES     = ${CrSDK_LIBRARIES}") 
  message("CrSDK_SAMPLE_SOURCE_PATH = ${CrSDK_SAMPLE_SOURCE_PATH}")
  message("CrSDK_VERSION_MAJOR = ${CrSDK_VERSION_MAJOR}")
  message("CrSDK_VERSION_MINOR = ${CrSDK_VERSION_MINOR}")
  message("CrSDK_VERSION_PATCH = ${CrSDK_VERSION_PATCH}")
endif(CrSDK_FOUND)
