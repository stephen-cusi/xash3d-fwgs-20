🌐 [English](bug-compatibility.md) | 🇨🇳 [中文](bug-compatibility.zh-CN.md)

# Xash3D FWGS 的 Bug 兼容性

Xash3D FWGS 有一个特殊模式，用于兼容依赖原始引擎 bug 的游戏。在此模式下，我们模拟了某些函数的行为，这可能有助于运行依赖引擎 bug 的 mod，但默认启用它们可能会破坏大多数其他游戏。

目前，我们只实现了 GoldSrc 的 bug 兼容性。可以通过 `-bugcomp` 命令行开关启用。

当 `-bugcomp` 不带参数指定时，将启用所有兼容性。此行为在未来版本中可能会更改或移除。

当 `-bugcomp` 带参数指定时，参数会被解释为用 `+` 分隔的标志。这样可以组合多个级别的 bug 兼容性。

## GoldSrc Bug 兼容性

| 标志 | 描述 | 需要此标志的游戏 |
| ------- | ----------- | ---------------------------- |
| `peoei` | 将 `pfnPEntityOfEntIndex` 的行为恢复为 GoldSrc，由于不正确的玩家索引比较，它对最后一个玩家返回 NULL | * Counter-Strike: Condition Zero - Deleted Scenes |
| `gsmrf` | 在游戏 DLL 尝试写入内部引擎消息（通常是 GoldSrc 协议特定的）时重写消息。<br>目前仅支持 `svc_spawnstaticsound`，更多消息可按请求添加。 | * 基于 MetaMod/AMXModX 的 mod |
| `sp_attn_none` | 使衰减为零的声音具有空间化效果，即具有立体声效果。 | 可能是所有为 GoldSrc 制作的游戏。 |
| `get_game_dir_full` | 使服务器在 `pfnGetGameDir` API 函数中返回完整路径 | 面向 HL 1.1.1.1 之前引擎的 mod，根据 MetaMod [文档](http://metamod.org/engine_notes.html#GetGameDir) |
