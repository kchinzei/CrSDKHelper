# RemoteCli example

This example will generate `RemoteCli`, indeed the same program that comes with Sony's SDK.
All sources are 'borrowed' from where the SDK kit expected to have.

## Build & Run

Build from command line. Assume your current folder is that of this readme.

```bash
> mkdir build
> cd build
> cmake ..
> make
> ./RemoteCli
```

If you move this folder somewhere else, you need to tell where is `FindCrSDK.cmake`.

```bash
> cmake -DCrSDK_ROOT_DIR=/full/path/to/sony/CrSDK_v1 ..
```

or

```bash
> cmake -DCMAKE_MODULE_PATH=/full/path/to/CrSDKHelper/cmake ..
```

depending on how you organize your folder structure.

## License

The MIT License (MIT) Copyright (c) K. Chinzei (kchinzei@gmail.com)  
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.