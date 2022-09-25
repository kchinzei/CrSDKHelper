# About CrSDK Helper

CrSDK Helper is a supplement for [Sony's Remote Camera SDK](https://support.d-imaging.sony.co.jp/app/sdk/en/index.html) released in 2021.
CrSDK Helper adds the following

- `FindCrSDK.cmake` and `CrSDKUtils.cmake` to organize your cmake project in cmake-ish way.
- Example c++/cmake folders.
- Python wrapper (in future).

---

## What is [Sony Remote Camera SDK](https://support.d-imaging.sony.co.jp/app/sdk/en/index.html)?

[Sony Remote Camera SDK](https://support.d-imaging.sony.co.jp/app/sdk/en/index.html) (CrSDK) enables a Win/Mac/Linux computer to connect multiple Sony cameras via USB or wired LAN connections.
Sony had another API for Sony cameras, but completely replaced by CrSDK. See [here](https://developer.sony.com/develop/cameras/).

CrSDK is a suite of C++ classes and binary libraries to link from c++ projects.
Past wrapper projects in github (
    [ex1](https://github.com/Bloodevil/sony_camera_api), 
    [ex2](https://github.com/JamesMcMinn/sonycrapi),
    [ex3](https://nerelicpast.com/?_=%2Fnaoyuki-sato%2FCamera-Remote-API%23Fc4PUI%2BG6VPSodUGYlCLziUM)
    ), or in 
    [rubygem](https://www.rubydoc.info/gems/sony-camera-remote/0.0.1)
do not work with CrSDK, because new API is completely incompatible.

## What is CrSDK Helper?

CrSDK Helper provides you two cmake modules, `FindCrSDK.cmake` and `CrSDKUtils.cmake`.
They make your cmake project very simple and relocatable at any place in the file system.

CrSDK Helper has been tested on MacOS Monterey and Linux32 ARMv7 (Raspberry Pi 4) to compile and run with RX0 MarkII.  
Cmake ver. 3.20 or newer is required.
As of September 2022, cmake in the Raspberry Pi repository was 3.18.
You will need to build cmake from [the source](https://github.com/Kitware/CMake).

---

## Using CrSDK Helper

After cloning from this repository, you put `CrSDK_v1` folder downloaded and expanded from [Sony website](https://support.d-imaging.sony.co.jp/app/sdk/en/index.html) like this:

```
CrSDKHelper
    +-- cmake
    |    +-- CrSDKUtils.cmake
    |    +-- FindCrSDK.cmake
    +-- CrSDK_v1
    |    +-- ...
    |    ...
    +-- examples
    |    +-- cpp
    |         +-- ...
    +-- README.md
    +-- test
         +-- ...
         ...
```

You can put `CrSDKHelper` folder at any place.
You can also put `CrSDK_v1` folder at any place, but you will need to tell where it is when running `cmake`.

You can start playing with CrSDK Helper from building `RemoteCli` in the examples.
It is indeed same as the Sony SDK's original example but with cleaner CMakeLists.txt.  
First, make sure `RemoteCli` in the Sony's example is successfully built by following the instruction came with it.
After that, all you do is follwing this from command line:

```sh
> cd CrSDKHelper/examples/cpp/RemoteCli
> mkdir build
> cd build
> cmake ..
> make
```

(You can also use ccmake or cmake-gui.exe for Windows)
Then, there is the app `RemoteCli` in the build folder.

## Why CrSDK Helper?

CrSDK Helper actually does not add any extra functionality to Sony SDK.
Then why CrSDK Helper?
Reasons are:

- You can keep your `CMakeLists.txt` simpler.
Please compare the original `CMakeLists.txt` in `CrSDK_v1` and the one under `CrSDKHelper/examples/cpp/RemoteCli`.
- You can put your project outside `CrSDK_v1`.
You can put it at any place in the filesystem.
- You can build your own project while keeping the original SDK intact.
This makes managing both your project and Sony SDK easier.

---

## License

The MIT License (MIT) Copyright (c) K. Chinzei (kchinzei@gmail.com)  
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.