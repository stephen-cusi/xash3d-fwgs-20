🌐 [English](ports.md) | 🇨🇳 [中文](ports.zh-CN.md)

Xash3D FWGS 旨在轻松移植到各种平台，但主要问题是维护这些移植。

此页面关于已合并到主源代码树的移植及其负责的开发者。

有关移植指南，请阅读 engine-porting-guide.md。

状态：
* **已支持**：活跃，确认完全功能，在 CI 上构建。
* **孤立**：已做一些工作但未完成或由于缺乏人力资源而未积极测试。
* **进行中**：活跃，开发中。
* **旧引擎**：移植用于旧引擎分支。
* **已弃用**：不再支持。

表格按状态和平台排序。

| 平台 | 状态 | 维护者 | 备注
| -------- | ------ | ---------- | ----
| Android | 已支持 | @Velaron |
| *BSD | 已支持 | @nekonomicon |
| GNU/Linux | 已支持 | @a1batross, @mittorn |
| macOS | 已支持 | @sofakng |
| PSVita | 已支持 | @fgsfdsfgs |
| Switch | 已支持 | @fgsfdsfgs |
| Windows | 已支持 | @a1batross, @SNMetamorph |
| iOS | 已支持 | @ksagameng2 |
| DOS4GW | 孤立 | N/A | 很长时间未确认工作
| Haiku | 孤立 | N/A | 由 #478 和 #483 添加
| IRIX | 孤立 | N/A | 未完成，编译但需要大端移植
| MotoMAGX | 孤立 | N/A | 应该工作但用于此平台的编译器非常不稳定且容易崩溃（它是 GCC 3.4）
| SerenityOS | 孤立 | N/A | 工作但未彻底测试
| Solaris | 孤立 | N/A | 工作但未彻底测试
| WebAssembly System Interface | 孤立 | N/A | 未完成，WASI 缺少很多我们想使用的 API
| Dreamcast | 进行中 | @maximqaxd | [GitHub 仓库](https://github.com/maximqaxd/xash3d-fwgs_dc/)
| PSP | 进行中 | @Crow_bar, @Velaron | [GitHub 仓库](https://github.com/Crow-bar/xash3d-fwgs)
| Wii | 进行中 | 协作努力 | [GitHub 仓库](https://github.com/saucesaft/xash3d-wii)
| Emscripten | 旧引擎 | N/A |
| 3DS | 旧引擎分支 | N/A | [GitHub 仓库](https://github.com/masterfeizz/Xash3DS)
| Oculus Quest | 旧引擎分支 | N/A | [GitHub 仓库](https://github.com/DrBeef/Lambda1VR)
