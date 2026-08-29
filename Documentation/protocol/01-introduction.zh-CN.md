🌐 [English](01-introduction.md) | 🇨🇳 [中文](01-introduction.zh-CN.md)

# Xash3D FWGS 协议支持

Xash3D FWGS 目前支持四种网络协议：
* 版本 49，约 2018 年在 Xash3D 中引入。
* 版本 48，用于 Xash3D FWGS 0.19 及更早版本。已弃用，将来会移除。
* GoldSrc 版本 48，用于当前 GoldSource 版本。
* Quake 版本 15，仅用于 Quake Wrapper mod 的演示播放。

在服务器端，我们只支持 Xash3D 49 协议，但 bugcomp `gsmrf` 模式可以将 GoldSrc 48 消息实时转换为 Xash3D 49，用于某些直接写入引擎内部消息的 mod。

在以下文档中，我们只介绍版本 49，因为其他内容要么不是 Xash3D 特有的，要么已弃用。
