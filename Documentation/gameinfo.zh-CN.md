🌐 [English](gameinfo.md) | 🇨🇳 [中文](gameinfo.zh-CN.md)

# 游戏定义和信息文件

gameinfo.txt 是任何基于 Xash3D 的游戏的基本部分。它允许游戏创作者进行基本自定义，如设置游戏标题、DLL 路径等。

本文档定义了 gameinfo.txt 语法、支持的键和 liblist.gam 转换规则，适用于引擎的最新版本。引擎开发者的注意：请保持此文档与实现同步。

## gameinfo.txt 语法

* gameinfo.txt 是简单的键值列表，用换行符分隔。
* 你可以使用双斜杠（//）添加单行注释。
* 键可以接受整数、浮点数、字符串或布尔值。
* 布尔键使用 0 表示 false，1 表示 true。
* 要在字符串值中包含空格，必须用双引号括起来。然后，要包含双引号，必须用反斜杠转义，要包含反斜杠需要使用双反斜杠。

示例：
```
// 这是一个注释 :)
// 这是另一个注释
some_integer_key 123

this_is_float_key 13.37 // 可选注释

enable_feature 1 // 布尔值，1 启用，0 禁用

example_string_key string_value
example_spaces "带空格的字符串"
example_title "Fate\\Stay Night" // 引擎会解析为 Fate\Stay Night
```

## gameinfo.txt 键

这是引擎支持的所有 gameinfo.txt 键的列表。注意引擎会静默跳过所有无法识别的键。

| 键 | 类型 | 默认值 | 描述 |
| ---------------- | ---------- | --------------- | ----------- |
| `ambient0` | string | 空字符串 | 自动环境音 |
| `ambient1` | string | 空字符串 | 自动环境音 |
| `ambient2` | string | 空字符串 | 自动环境音 |
| `ambient3` | string | 空字符串 | 自动环境音 |
| `basedir` | string | `valve` | 游戏基础目录，用于在游戏间共享资源 |
| `date` | string | 空字符串 | 游戏发布日期。未使用。 |
| `dllpath` | string | `cl_dlls` | 游戏 DLL 路径。引擎将在此目录中搜索自定义 DLL（客户端或菜单等），`gamedll` 除外，见下文。 |
| `fallback_dir` | string | 空字符串 | 附加游戏基础目录 |
| `gamedir` | string | 当前 gamedir | 游戏目录，在 FWGS 中被忽略，因为游戏目录由游戏目录名称定义 |
| `gamedll` | string | `dlls/hl.dll` | 32 位 x86 Windows 的游戏服务器 DLL（详情参见 LibraryNaming.md） |
| `gamemode` | string | 空字符串 | 游戏类型。设置为 `singleplayer_only` 或 `multiplayer_only` 时分别标记游戏为仅 SP 或仅 MP，在游戏 UI 中隐藏选项。省略此键或使用自定义值将游戏标记为同时兼容 MP 和 SP。 |
| `icon` | string | `game.ico` | 游戏图标。引擎会自动追加 .ico 并可能自动切换到 .tga 图标 |
| `max_beams` | integer | 128 | 光束限制，最小 64，最大 512 |
| `max_edicts` | integer | 900 | 实体限制，最小 600，最大 8192（协议限制）。在 FWGS 中，最小值为 64。 |
| `max_particles` | integer | 4096 | 粒子限制，最小 1024，最大 131072 |
| `max_tempents` | integer | 500 | 临时实体限制。最小 300，最大 2048 |
| `mp_entity` | string | `info_player_deathmatch` | 用于将地图标记为多人游戏的实体 |
| `mp_filter` | string | 空字符串 | 设置后，用于过滤多人游戏地图而非 `mp_entity`。<br>如果地图名称以此过滤器相同的字符开头，则视为多人游戏地图 |
| `nomodels` | boolean | 0 | 设置为 1 时，禁止在 UI 中更改玩家模型 |
| `noskills` | boolean | 0 | 设置为 1 时，禁止选择游戏难度 |
| `secure` | boolean | 0 | 设置为 1 时，原始 Unkle Mike 的引擎将完全禁用开发者模式。FWGS 忽略但保留此值以保持兼容性。 |
| `size` | integer | 0 | 游戏目录大小（字节），仅在"更改游戏"对话框中使用 |
| `startmap` | string | `c0a0` | 新游戏中使用的地图名称 |
| `sp_entity` | string | `info_player_start` | 用于将地图标记为单人游戏的实体。用于地图验证 |
| `title` | string | `New Game` | 游戏标题，用于窗口标题、默认服务器名称等。 |
| `trainmap` | string | `t0a0` | 训练地图（Hazard Course）的名称 |
| `type` | string | 空字符串 | 游戏类型，用于"更改游戏" UI。 |
| `url_info` | string | 空字符串 | 游戏主页 URL，用于"更改游戏" UI |
| `url_update` | string | 空字符串 | 游戏更新 URL，用于"设置" UI |
| `version` | float | 1.0 | 游戏版本，用于"更改游戏"对话框和服务器信息 |

## FWGS 特定的 gameinfo.txt 键

这些字符串是 Xash3D FWGS 特有的。

| 键 | 类型 | 默认值 | 描述 |
| ----------------------- | ---------- | ------------------------ | ----------- |
| `animated_title` | boolean | 0 | 在主菜单中使用动画标题（模仿 Half-Life 25 周年更新的 WON Half-Life logo.avi） |
| `autosave_aged_count` | integer | 2 | 自动保存轮换中使用的自动保存限制 |
| `gamedll_linux` | string | 从 `gamedll` 生成 | 32 位 x86 Linux 的游戏服务器 DLL（详情参见 LibraryNaming.md） |
| `gamedll_osx` | string | 从 `gamedll` 生成 | 32 位 x86 macOS 的游戏服务器 DLL（详情参见 LibraryNaming.md） |
| `hd_background` | boolean | 0 | 为主菜单使用高清背景（Half-Life 25 周年更新） |
| `internal_vgui_support` | boolean | 0 | 仅用于程序员！PrimeXT 需要设置为 1！<br>设置为 1 时，引擎不会加载 vgui_support DLL，因为 VGUI 支持在游戏端完成（或有意忽略）。 |
| `render_picbutton_text` | boolean | 0 | 设置为 1 时，UI 不会使用预渲染的 `btns_main.bmp` 并动态渲染它们 |
| `quicksave_aged_count` | integer | 2 | 快速保存轮换中使用的快速保存限制 |
| `demomap` | string | 空字符串 | 演示章节地图的名称（Half-Life Uplink） |

## 关于 GoldSrc liblist.gam 支持的说明

由于 Xash3D 意外支持 GoldSrc 游戏，它也支持解析 liblist.gam。\
如果 gameinfo.txt 不存在，或者其修改时间戳早于 liblist.gam，Xash3D 将使用此文件。

> [!NOTE]
> 从 2025 年 1 月开始，Xash3D FWGS 不再自动从 liblist.gam 生成 gameinfo.txt。键转换表仍然保留，但如果你想使用 gameinfo.txt 代替 liblist.gam，可以在控制台中执行 `fs_make_gameinfo`。

对于只计划支持 Xash3D 的游戏创作者，不建议使用此文件。

下表定义了从 liblist.gam 到 gameinfo.txt 的转换规则。某些键的解释确实与 `gameinfo.txt` 不同，在这种情况下会留下注释。如果 `liblist.gam` 键不在此表中，则被忽略。

| `liblist.gam` 键 | `gameinfo.txt` 键 | 备注 |
| ----------------- | ------------------ | ---- |
| `animated_title` | `animated_title` | |
| `edicts` | `max_edicts` | |
| `fallback_dir` | `fallback_dir` | |
| `game` | `title` | |
| `gamedir` | `gamedir` | |
| `gamedll` | `gamedll` | |
| `gamedll_linux` | `gamedll_linux` | |
| `gamedll_osx` | `gamedll_osx` | |
| `hd_background` | `hd_background` | |
| `icon` | `icon` | |
| `mpentity` | `mp_entity` | |
| `mpfilter` | `mp_filter` | |
| `nomodels` | `nomodels` | |
| `secure` | `secure` | 在 GoldSrc 中用于标记多人游戏为启用反作弊。<br>原始 Xash3D 误解其值以禁止控制台和开发者模式。<br>FWGS 忽略此键但保留以保持兼容性。 |
| `startmap` | `startmap` | |
| `size` | `size` | |
| `trainingmap` | `trainmap` | |
| `trainmap` | `trainmap` | |
| `type` | `type` 和 `gamemode` | 在 `liblist.gam` 中此键同时作为 `type` 和 `gamemode` 工作。<br>如果值为 `singleplayer_only` 或 `multiplayer_only`，游戏被标记为仅 SP 或仅 MP，`gameinfo.txt` type 设置为 `Single` 或 `Multiplayer`。<br>任何自定义值将游戏标记为同时兼容 SP 和 MP，type 设置为自定义值。 |
| `url_dl` | `url_update` | |
| `url_info` | `url_info` | |
| `version` | `version` | |
