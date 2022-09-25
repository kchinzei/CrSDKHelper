# CrSDK Helper

CrSDK Helper は，2021年に公表された[Sony Remote Camera SDK](https://support.d-imaging.sony.co.jp/app/sdk/ja/index.html)の使い勝手を向上させるために製作しました．
CrSDK Helper は以下を追加します：

- `FindCrSDK.cmake` と `CrSDKUtils.cmake`：よりcmakeらしいユーザープロジェクト
- C++/cmakeのサンプルフォルダー
- Pythonラッパー（未着手）

---

## [Sony Remote Camera SDK](https://support.d-imaging.sony.co.jp/app/sdk/ja/index.html)について

[Sony Remote Camera SDK](https://support.d-imaging.sony.co.jp/app/sdk/ja/index.html) (CrSDK)は，Win/Mac/LinuxマシンからSonyのカメラをUSBまたは有線LAN接続で制御するためのAPIです．
Sonyは以前，カメラ制御用のAPIキットを公表していましたが，CrSDKはこれに代わるものです（[こちら](https://developer.sony.com/ja/develop/cameras/ja)）.

CrSDK はC++クラスライブラリとC++プロジェクトでリンクするためのバイナリファイルで構成されます．
Github上の過去のラッパープロジェクト（
    [ex1](https://github.com/Bloodevil/sony_camera_api), 
    [ex2](https://github.com/JamesMcMinn/sonycrapi),
    [ex3](https://nerelicpast.com/?_=%2Fnaoyuki-sato%2FCamera-Remote-API%23Fc4PUI%2BG6VPSodUGYlCLziUM)
    ）や 
    [rubygem](https://www.rubydoc.info/gems/sony-camera-remote/0.0.1)
は旧SDKで設計されているため，CrSDK上では動作しません．

## CrSDK Helperについて

CrSDK Helper は２つのcmakeモジュール  `FindCrSDK.cmake` 及び `CrSDKUtils.cmake` を提供します．
これらを使うとcmakeプロジェクトをシンプルかつファイルシステム上でフレキシブルに配置できます．

MacOS Monterey及びLinux32 ARMv7 (Raspberry Pi 4)上でコンパイル，カメラとしてRX0 MarkIIを使ってテストしています．  
Cmakeとしてver. 3.20以上を必要としています．
2022年9月現在，Raspberry Piのレポジトリでは3.18までしか用意されていませんので，cmakeを[ソース](https://github.com/Kitware/CMake)からビルドする必要がありました．

---

## CrSDK Helperの使い方

このレポジトリをgit cloneしたのち，[ソニーのサイト](https://support.d-imaging.sony.co.jp/app/sdk/ja/index.html)からダウンロードして解凍した `CrSDK_v1` フォルダーを以下のように配置してください．

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

`CrSDKHelper` フォルダーはファイルシステム上の任意の場所に配置できます．
`CrSDK_v1` フォルダーも任意の場所に配置できますが，上記以外の場合は `cmake` を走らせた時に `CrSDK_v1` の場所を指定しなければなりません．

最初は，examples 内の `RemoteCli` をビルドしてみましょう．
このサンプルはSony SDKのサンプルアプリそのものです．ソースファイルはそのまま借り物です．しかしスッキリした CMakeLists.txt ファイルとなっています．

まず，Sonyのサンプルの `RemoteCli` がSDK付属の説明書に従ってビルドできることを確認してください．
次に，以下のようにコマンドラインで実行してください：

```sh
> cd CrSDKHelper/examples/cpp/RemoteCli
> mkdir build
> cd build
> cmake ..
> make
```

（ccmake，Windowsの場合はcmake-gui.exeを使うこともできます）
これで，実行ファイル `RemoteCli` が build フォルダー内にできているはずです．

## 独自のプロジェクトを作るには

現在はプロジェクトテンプレートがありません．
よって，`examples/cpp/RemoteCli` をコピーして始めるのが良いと思います．
`CrSDK_v1/app` フォルダ内のクラスをそのまま使いたいことがあるかもしれません（例えば，`cli::Text`）．
Cmakeの変数 `CrSDK_SAMPLE_SOURCE_PATH` を使うとそのフォルダへの絶対パスを得ることができます．

## なぜCrSDK Helper?

CrSDK Helper は CrSDK に新規機能を付加するものではありません．しかし次のメリットがあります：

- ユーザープロジェクトの `CMakeLists.txt` がシンプルになる．
CrSDK についてきたオリジナルの `CMakeLists.txt` と，`examples/cpp/RemoteCli` 内のそれを比較してみてください．
- `CrSDK_v1` フォルダをユーザープロジェクトのフォルダと分離できる．
それぞれファイルシステム上のどこにあっても構いません．
- そのため，オリジナルのSDKの中身をいじらずにユーザープロジェクトを構築できる．
これによって，プロジェクトの更新管理が容易になります．

---

## License

The MIT License (MIT) Copyright (c) K. Chinzei (kchinzei@gmail.com)  
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.