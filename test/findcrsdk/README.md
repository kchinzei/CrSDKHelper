# findcrsdk

It displays variables set by `FindCrSDK.cmake`.

## Build & Run

```bash
> mkdir build
> cd build
> cmake ..
CrSDK_FOUND = TRUE
CrSDK_ROOT_DIR      = /Users/me/src/CrSDKHelper/CrSDK_v1
CrSDK_INCLUDE_PATH  = /Users/me/src/CrSDKHelper/CrSDK_v1/app/CRSDK/
CrSDK_INCLUDE_FILES = CameraRemote_SDK.h
CrSDK_SOURCE_FILES  = 
CrSDK_LIBRARY_PATH  = /Users/me/src/CrSDKHelper/CrSDK_v1/external/crsdk
CrSDK_LIBRARY       = /Users/me/src/CrSDKHelper/CrSDK_v1/external/crsdk/libCr_Core.dylib
CrSDK_LIBRARIES     = /Users/me/src/CrSDKHelper/CrSDK_v1/external/crsdk/libCr_Core.dylib
CrSDK_SAMPLE_SOURCE_PATH = /Users/me/src/CrSDKHelper/CrSDK_v1/app/
CrSDK_VERSION_MAJOR = 1
CrSDK_VERSION_MINOR = 05
CrSDK_VERSION_PATCH = 00
-- Configuring done
-- Generating done
-- Build files have been written to: /Users/me/src/CrSDKHelper/test/findcrsdk/build
```

## License

The MIT License (MIT) Copyright (c) K. Chinzei (kchinzei@gmail.com)  
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.