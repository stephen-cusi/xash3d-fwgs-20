🌐 [English](debugging-using-minidumps.md) | 🇨🇳 [中文](debugging-using-minidumps.zh-CN.md)

# 使用 minidump 文件调试你的 mod（仅限 Windows）
Minidump 文件是调试 mod 的绝佳工具，适用于 mod 发布后或捕获仅在特定配置中出现的崩溃。它包含大量对调试有用的信息，因此文件不小：大约数百甚至数千兆字节。但这不是问题，因为 minidump 文件使用通用算法压缩效果很好。
以下是使用此调试工具的简要算法：

1. 用户使用 `-minidumps` 启动参数启动你的 mod
2. 最终，用户的机器上发生崩溃，minidump 文件被写入。此文件扩展名为 `.mdmp`，位于 mod 文件夹所在的同一文件夹中
3. 用户将此 minidump 文件打包为 .zip/.7z 归档，并以某种方式发送给开发者
4. 开发者只需在 Visual Studio 中打开 minidump 文件，然后会打开一个虚拟调试会话，崩溃原因很容易检测：你可以看到调用堆栈、局部函数变量和全局变量、异常信息以及许多其他信息

你可以在这篇[精彩文章](https://learn.microsoft.com/en-us/windows/win32/dxtecharts/crash-dump-analysis?source=recommendations#writing-a-minidump)中找到关于 minidump 的更多信息。
