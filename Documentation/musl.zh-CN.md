🌐 [English](musl.md) | 🇨🇳 [中文](musl.zh-CN.md)

# Xash3D FWGS 在 `musl` 上的运行

Xash3D FWGS 可以直接在 `musl` 上运行。但引擎不再尝试区分 glibc 和 musl。如果你看到类似以下的错误：

```
Host_InitError: can't initialize cl_dlls/client.so: Error relocating valve/cl_dlls/client.so: __sprintf_chk: symbol not found
```

... 或者你知道你运行的游戏是链接到 glibc 的，可以尝试使用 `libgcompat`，如下所示：

```
$ LD_PRELOAD=/lib/libgcompat.so.0 ./xash3d ...
```

它会自动添加 glibc 二进制文件通常需要的缺失符号。在未来，如果有必要，我们可能会自动将引擎链接到 `libgcompat`，以提高与预构建或闭源游戏的兼容性。
