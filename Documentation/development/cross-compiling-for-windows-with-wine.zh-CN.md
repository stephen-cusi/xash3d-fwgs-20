🌐 [English](cross-compiling-for-windows-with-wine.md) | 🇨🇳 [中文](cross-compiling-for-windows-with-wine.zh-CN.md)

# 使用 Wine 交叉编译 Windows 版本

这可以在不使用虚拟机或双启动 Windows 的情况下，在 Wine 中测试引擎。

0. 克隆并安装 https://github.com/mstorsjo/msvc-wine （你可以跳过 CMake 部分）
1. 设置环境变量 MSVC_WINE_PATH 为已安装的 MSVC 工具链路径
2. 预加载 wine：`wineserver -k; wineserver -p; wine64 wineboot`
3. 运行 `PKGCONFIG=/bin/false ./waf configure -T <build-type> --enable-wine-msvc --sdl2=../SDL2_VC`。配置步骤将比平时花费更多时间。
4. .. 其他典型的从控制台构建步骤 ...

> [!NOTE]
> 注意这里使用了 PKGCONFIG=/bin/false。我们禁用 pkg-config 以避免意外引入系统范围的依赖并强制从源代码构建它们。在未来的构建中，我们可能会设置自定义目录来引入依赖，比如 ffmpeg...
