🌐 [English](README.md) | 🇨🇳 [中文](README.zh-CN.md)

> [!CAUTION]
> **请仅从官方来源下载 Xash3D FWGS。** 第三方构建、"修改版启动器"、"优化"重打包和随机镜像经常捆绑恶意软件、挖矿程序、间谍软件和凭据窃取程序。我们无法为我们未构建的任何内容提供担保。请仅从[发布页面](https://github.com/FWGS/xash3d-fwgs/releases/tag/continuous)获取官方二进制文件。

# Xash3D FWGS 引擎 <img align="right" width="128" height="128" src="https://github.com/FWGS/xash3d-fwgs/raw/master/game_launch/icon-xash-material.png" alt="Xash3D FWGS icon" />
[![GitHub Actions Status](https://github.com/FWGS/xash3d-fwgs/actions/workflows/c-cpp.yml/badge.svg)](https://github.com/FWGS/xash3d-fwgs/actions/workflows/c-cpp.yml) [![FreeBSD Build Status](https://img.shields.io/cirrus/github/FWGS/xash3d-fwgs?label=freebsd%20build)](https://cirrus-ci.com/github/FWGS/xash3d-fwgs) \
[![Discord Server](https://img.shields.io/discord/355697768582610945?logo=Discord&label=International%20Discord%20chat)](http://xash.su/discord/) [![Russian speakers Telegram Chat](https://img.shields.io/badge/Russian_speakers_Telegram_chat-gray?logo=Telegram)](https://t.me/flyingwithgauss) \
[![Download Daily Build](https://img.shields.io/badge/downloads-testing-orange)](https://github.com/FWGS/xash3d-fwgs/releases/tag/continuous)

Xash3D（[发音](https://ipa-reader.com/?text=ks%C9%91%CA%82) `[ksɑʂ]`）FWGS 是一个游戏引擎，旨在提供与 Half-Life 引擎的兼容性并扩展它，同时为游戏开发者提供熟悉的工作流程。

Xash3D FWGS 是 Unkle Mike 的原始 [Xash3D 引擎](https://www.moddb.com/engines/xash3d-engine)的深度修改分支。

## 捐赠
[![Donate to FWGS button](https://img.shields.io/badge/Donate_to_FWGS-%3C3-magenta)](Documentation/donate.zh-CN.md) \
如果你喜欢 Xash3D FWGS，请考虑支持个人引擎维护者。通过支持我们，你帮助继续开发这个游戏引擎。赞助链接可在[文档](Documentation/donate.zh-CN.md)中找到。

## 分支特性
* Steam Half-Life (HLSDK 2.5) 支持。
* 跨平台和现代编译器支持：支持 Windows、Linux、BSD 和 Android 上的 x86 和 ARM 以及[更多](Documentation/ports.md)。
* 更好的多人游戏：多个主服务器、无头专用服务器、语音聊天、[GoldSrc 协议支持](Documentation/goldsrc-protocol-support.md)和 IPv6 支持。
* 多渲染器支持：OpenGL、GLESv1、GLESv2 和软件渲染。
* 高级虚拟文件系统：`.pk3` 和 `.pk3dir` 支持，与 GoldSrc FS 模块兼容，跨平台快速大小写不敏感模拟。
* 移动 API：移动设备上更好的游戏集成（振动、触摸控制）。
* 不同的输入方式：触摸和游戏手柄，以及鼠标和键盘。
* TrueType 字体渲染，作为 mainui_cpp 的一部分。
* 外部 VGUI 支持模块。
* PNG 和 KTX2 图像格式支持。
* Ogg Vorbis（`.ogg`）和 Ogg Opus（`.opus`）音频格式支持。
* [一系列小改进](Documentation/)，不破坏兼容性。

## 安装和运行
0) 获取 Xash3D FWGS 二进制文件：你可以使用 [testing](https://github.com/FWGS/xash3d-fwgs/releases/tag/continuous) 构建或从源代码编译引擎。
1) 将引擎二进制文件复制到某个目录。
2) 将 `valve` 目录从 [Half-Life](https://store.steampowered.com/app/70/HalfLife/) 复制到引擎二进制文件所在的目录。
如果你的 CPU 不是 x86 兼容的或你运行的是 64 位版本的引擎，你可能需要编译 [Half-Life SDK](https://github.com/FWGS/hlsdk-portable)。
此仓库包含我们的 HLSDK 分支和 Half-Life 扩展及一些 mod 的恢复源代码。
你仍然需要复制 `valve` 目录，因为所有游戏资源都在那里。
3) 运行主可执行文件（`xash3d.exe` 或 AppImage）。

更多信息，请使用 `-help` 命令行参数运行 Xash3D。

### Android
0) 安装 APK 文件。
1) 将 `valve` 目录复制到内部存储中名为 `xash` 的文件夹。
2) 从应用内运行游戏。

## 报告问题
* 问题接受英文和俄语。
* 仅当你运行合法获取的产品（例如 Steam 中的 Half-Life）时才会被接受。

## 贡献代码
* 查看 CONTRIBUTING.md 文件。

## 构建说明
我们使用 Waf 构建系统。如果你有一些 Waf 相关的问题，我建议你阅读 [Waf Book](https://waf.io/book/)。

**注意：永远不要使用 GitHub 的 ZIP 归档。GitHub 不包含我们使用的外部依赖！**

### 前提条件
如果你的 CPU 是 x86 兼容的且你在 Windows 或 Linux 上，我们默认构建 32 位代码。这是为了保持与 Steam 上 Half-Life 及基于其引擎的游戏的兼容性。
即使 Xash3D FWGS 确实支持目标 64 位，你也无法在不从源代码重新编译的情况下加载游戏！

如果你的 CPU 不是 x86 兼容的或你决定构建 64 位版本的引擎，你可能需要编译 [Half-Life SDK](https://github.com/FWGS/hlsdk-portable)。
此仓库包含我们的 HLSDK 分支和 Half-Life 扩展及一些 mod 的恢复源代码。

#### Windows (Visual Studio)
* 安装 Visual Studio。
* 安装最新的 [Python](https://python.org) **或**如果你有 Chocolatey 则运行 `cinst python.install`。
* 安装最新的 [Git](https://git-scm.com/download/win) **或**如果你有 Chocolatey 则运行 `cinst git.install`。
* 下载 Visual Studio 的 [SDL2](https://libsdl.org/download-2.0.php) 开发包。
* 克隆此仓库：`git clone --recursive https://github.com/FWGS/xash3d-fwgs`。
* 确保你至少有 12GB 的可用空间来存储所有构建时依赖：约 10GB 用于 Visual Studio，300 MB 用于 Git，100 MB 用于 Python 等。

#### GNU/Linux
##### Debian/Ubuntu
* 仅用于 64 位 x86 操作系统上的 32 位引擎：
  * 在系统上启用 i386：`$ sudo dpkg --add-architecture i386`。
  * 安装 `aptitude`（[为什么？](https://github.com/FWGS/xash3d-fwgs/issues/1828#issuecomment-2415131759)）：`$ sudo apt update && sudo apt upgrade && sudo apt install aptitude`
  * 安装开发工具：`$ sudo aptitude --without-recommends install git build-essential gcc-multilib g++-multilib libsdl2-dev:i386 libfreetype-dev:i386 libopus-dev:i386 libbz2-dev:i386 libvorbis-dev:i386 libopusfile-dev:i386 libogg-dev:i386`。
  * 设置 PKG_CONFIG_PATH 环境变量指向 32 位库：`$ export PKG_CONFIG_PATH=/usr/lib/i386-linux-gnu/pkgconfig`。

* 用于 64 位 x86 和其他非 x86 系统上的 64 位引擎：
  * 安装开发工具：`$ sudo apt install git build-essential python libsdl2-dev libfreetype6-dev libopus-dev libbz2-dev libvorbis-dev libopusfile-dev libogg-dev`。

* 克隆此仓库：`$ git clone --recursive https://github.com/FWGS/xash3d-fwgs`。

##### RedHat/Fedora
* 仅用于 64 位 x86 操作系统上的 32 位引擎：
  * 安装开发工具：`$ sudo dnf install git gcc gcc-c++ glibc-devel.i686 SDL3-devel.i686 sdl2-compat-devel.i686 opus-devel.i686 freetype-devel.i686 bzip2-devel.i686 libvorbis-devel.i686 opusfile-devel.i686 libogg-devel.i686`。
  * 设置 PKG_CONFIG_PATH 环境变量指向 32 位库：`$ export PKG_CONFIG_PATH=/usr/lib/pkgconfig`。

* 用于 64 位 x86 和其他非 x86 系统上的 64 位引擎：
  * 安装开发工具：`$ sudo dnf install git gcc gcc-c++ SDL3-devel sdl2-compat-devel opus-devel freetype-devel bzip2-devel libvorbis-devel opusfile-devel libogg-devel`。

* 克隆此仓库：`$ git clone --recursive https://github.com/FWGS/xash3d-fwgs`。

#### Android (Windows/Linux/macOS)
* 安装 [Android Studio](https://developer.android.com/studio)（或命令行工具）。
* 安装 [Python](https://python.org)（至少 2.7，最新版本更好）。
* 安装 [Git](https://git-scm.com/download/win)。
* 安装 [Ninja](https://ninja-build.org/)。
* 安装 [CMake](https://cmake.org/)（用于某些依赖）。

* 克隆此仓库：`$ git clone --recursive https://github.com/FWGS/xash3d-fwgs`。

#### Windows on ARM (ARM64)
* 与 Windows (Visual Studio) 相同的前提条件，但安装 ARM64 工作负载。
* SDL2 官方 VC 包不包含 ARM64。你需要从源代码构建 SDL2：
  ```
  git clone --depth 1 --branch release-2.32.10 https://github.com/libsdl-org/SDL.git SDL2_src
  cmake -S SDL2_src -B SDL2_build -G "Visual Studio 17 2022" -A ARM64 -DCMAKE_INSTALL_PREFIX=SDL2_arm64
  cmake --build SDL2_build --config Release
  cmake --install SDL2_build --config Release
  ```
* 使用 `-8` 标志配置和构建：
  ```
  waf configure -s SDL2_arm64 -8 -T release --enable-bundled-deps --skip-sdl2-sanity-check
  waf build
  ```

#### iOS/iPadOS
* 从 App Store 安装 Xcode。
* 安装 [Homebrew 包管理器](https://brew.sh)。

* 运行以下命令安装构建依赖：`brew install python`。

* 克隆 SDL2 仓库 `$ git clone --recursive https://github.com/libsdl-org/SDL.git -b SDL2` 并通过导航到 SDL/Xcode/SDL 并打开 Xcode 项目来编译 iOS 框架。

* 克隆此仓库：`$ git clone --recursive https://github.com/FWGS/xash3d-fwgs`。

### 构建
#### Windows (Visual Studio)
0) 打开命令行。
1) 导航到 `xash3d-fwgs` 目录。
2) （可选）查看可用的构建选项：`waf --help`。
3) 配置构建：`waf configure --sdl2=c:/path/to/SDL2`。
4) 编译：`waf build`。
5) 安装：`waf install --destdir=c:/path/to/any/output/directory`。

#### Linux
如果在 amd64 上编译 32 位，请确保上一步中的 `PKG_CONFIG_PATH` 在运行 configure 之前正确设置。

0) （可选）查看可用的构建选项：`./waf --help`。
1) 配置构建：`./waf configure`（你需要在 64 位 x86 处理器上编译 64 位引擎时传递 `-8`）。
2) 编译：`./waf build`。
3) 安装：`./waf install --destdir=/path/to/any/output/directory`。

#### Android (Windows/Linux/macOS)
要构建，你应该将 [SDL](https://github.com/libsdl-org/SDL) 的 `SDL2` 分支和 [HLSDK-portable](https://github.com/FWGS/hlsdk-portable) 的 `mobile-hacks` 分支仓库克隆到 3rdparty 文件夹，之后你应该能够从 `android` 目录在 Android Studio 中打开项目或手动调用 Gradle 构建 APK。

#### iOS/iPadOS (仅限 MacOS)
0) （可选）查看可用的构建选项：`./waf --help`。
1) 配置构建：`./waf configure --ios --enable-bundled-deps --sdl2 (path/to/SDL2.framework)`，如果你想为模拟器构建，将 `--ios-simulator` 替换 `--ios`。
2) 编译 `./waf build`。
3) 导航到 `build` 并将编译好的 SDL2.framework 复制到那里，然后将游戏 dylib 添加到 `build/ios/libs/(gamedir)/(dlls/cl_dlls)`（你也可以运行 `scripts/ios/buildhlsdk.sh` 代替来自动创建带 hlsdk dylib 的 ipa）
4) 运行 `scripts/ios/createipa.sh` 创建可安装的 ipa

### 运行测试

测试通过将 `--enable-tests` 传递给 `./waf configure` 启用，可以通过 `./waf --alltests` 运行。

这会构建独立的单元测试和一个单独的引擎测试二进制文件（`xash3d_tests`），其中嵌入了引擎级测试。引擎测试二进制文件不需要游戏资源。
