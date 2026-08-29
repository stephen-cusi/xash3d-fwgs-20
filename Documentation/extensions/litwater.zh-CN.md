🌐 [English](litwater.md) | 🇨🇳 [中文](litwater.zh-CN.md)

## 光照贴图水面

Xash3D FWGS 支持光照贴图水面作为扩展。它添加了三个新的 cvar 和新的 worldspawn 键值。

### 对关卡设计师：

如果你是关卡设计师并打算让你的关卡具有光照贴图水面，可以将这些键值放入 worldspawn 实体描述中（始终是实体列表中的第一个实体）：

| 键 | 值 | 描述 |
| ---------------------- | ------- | ----------- |
| `_litwater` | integer | 设置为任何非零值以启用光照贴图水面。覆盖 `gl_litwater_force` cvar 值。 |
| `_litwater_minlight` | integer | 水面将接收的最小光照贴图值。有助于避免水面未正确照明时出现过暗区域。如果未设置，默认为零。 |
| `_litwater_scale` | float | 放大水面的光照贴图值。如果未设置，默认为 1.0。 |

### 对玩家：

某些地图已经有计算好的水面光照贴图，有时水面已经正确照明但关卡设计师未声明支持。

作为玩家，你可以在 `Video options` 菜单中启用它，或通过控制台使用 `gl_litwater_force` cvar。还有 `gl_litwater_minlight` 和 `gl_litwater_scale` cvar，功能与上面的键类似。默认值分别设置为 `192` 和 `1.25`，以略微避免不打算使用光照贴图水面的地图出现问题。
