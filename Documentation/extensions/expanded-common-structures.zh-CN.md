🌐 [English](expanded-common-structures.md) | 🇨🇳 [中文](expanded-common-structures.zh-CN.md)

# 引擎和 mod 使用的扩展结构
为了使在 64 位平台上移植和开发 mod 不那么痛苦，我们决定扩展几个结构的大小。
此信息在你使用像 XashXT、Paranoia 2: Savior 这样的代码库并希望为 64 位指针大小的平台编译 mod 时非常重要：你应该用新的定义替换旧的定义，否则你的 mod 将无法与 Xash3D FWGS 一起工作（通常是在启动地图时崩溃）。
| 结构名称 | 所在文件 | 64 位原始大小 | 64 位当前大小 |
|----------------|-----------------|-------------------------|------------------------|
|`mfaceinfo_t` | `common/com_model.h` | 176 字节 |  304 字节 |
|`decal_s` | `common/com_model.h` | 72 字节 |  88 字节 |
|`mextrasurf_t` | `common/com_model.h` | 376 字节 |  504 字节 |
