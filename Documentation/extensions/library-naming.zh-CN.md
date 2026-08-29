🌐 [English](library-naming.md) | 🇨🇳 [中文](library-naming.zh-CN.md)

我提出一种新的库命名方案，允许将 mod 和游戏以单个归档分发到不同的操作系统和 CPU：

图例：
* $os -- Q_buildos() 返回值，小写。
* $arch -- Q_buildarch() 返回值，小写。
* $ext -- 操作系统特定扩展名：dll、so、dylib 等。

方案如下：

1. 客户端库：
* ```client.$ext``` 用于 **Win/Lin/Mac** 上的 **x86**。
* ```client_$arch.$ext``` 用于 **Win/Lin/Mac** 上的 **非 x86**。
* ```client_$os_$arch.$ext``` 用于其他所有情况。

2. 菜单库：
* ```menu.$ext``` 用于 **Win/Lin/Mac** 上的 **x86**。
* ```menu_$arch.$ext``` 用于 **Win/Lin/Mac** 上的 **非 x86**。
* ```menu_$os_$arch.$ext``` 用于其他所有情况。

3. 服务器库：
* 在 **Win/Lin/Mac** 上的 **x86**，它**必须**使用 `gameinfo.txt` 中对应操作系统字段的原始 gamedll 名称。
* 在 **Win/Lin/Mac** 上的 **非 x86**，它**必须**使用 `gameinfo.txt` 中对应操作系统字段的原始 gamedll 名称，但在文件扩展名前附加 ```_$arch```。例如：```hl_amd64.so``` 或 ```cs_e2k.so```。
* 在其他所有情况下，它必须使用 ```gamedll_linux``` 字段中的 gamedll 名称，但在文件扩展名前附加 ```_$os_$arch```。例如：```hl_haiku_amd64.so``` 或 ```cs_freebsd_armhf.so```。
为什么用 ```gamedll_linux``` 而不是 ```gamedll```？因为这样看起来更合理，大多数操作系统是 *nix 风格的，与 Linux 共享代码，而不是与 Windows。

4. 刷新库：不需要，因为 RefAPI 不稳定，不打算随 mod 分发。

对于随**引擎**分发的任何库，应使用对操作系统移植更方便的命名方案。

问题 #0。ABI 和 Q_buildarch 之间的不一致。\
解决方案：将 Q_buildarch 返回值更改为使用 Debian 风格的架构列表：https://www.debian.org/ports/，其中包括大/小端和硬/软浮点 ARM 的特殊命名。

问题 #1：构建系统集成。\
解决方案：实现为 [LibraryNaming.cmake](https://github.com/FWGS/hlsdk-portable/blob/master/cmake/LibraryNaming.cmake) 和 [library_naming.py](https://github.com/FWGS/hlsdk-portable/blob/master/scripts/waifulib/library_naming.py) 扩展，参见

问题 #2（与 #0 相关）：我们实际需要处理哪些 ARM 变体？\
解决方案：仅小端，因为没有已知的大端 ARM 平台。\
架构编码方式：
* ```armvxy```，其中 `x` 是 ARM 指令集级别，`y` 是硬浮点 ABI 存在标志：`hf` 表示使用硬浮点 ABI，否则为 `l`。

问题 #3：一些 mod（如 The Specialists、Tyrian 等）已经对 gamedll 路径应用了 _i386、_i686 后缀：\
解决方案：在 **Win/Lin/Mac** 上的 x86，不做任何更改。否则，去掉 _i?86 部分并遵循常规方案。

参见讨论：https://github.com/FWGS/xash3d-fwgs/issues/39

问题 #4：在 Android 上通过 APK 分发游戏库时，它们无法加载。\
解决方案：在 APK 中分发游戏时，在 build.gradle 中启用 `useLegacyPackaging` 选项。在 Android 上始终强制游戏库具有 `lib` 前缀，无论是否打包在 APK 中。
