🌐 [English](addon-folders.md) | 🇨🇳 [中文](addon-folders.zh-CN.md)

# Xash3D FWGS 中的附加文件夹

Xash3D FWGS 同时支持 GoldSource 风格的附加文件夹和一些自有文件夹。每个目录可以有自己的归档文件，这些归档文件将以比目录本身更低的优先级挂载。

以下是挂载映射，按优先级从低到高排列。

|--------------------|------|
| 目录 | 备注 |
|--------------------|------|
| `$game/downloaded` | 始终添加。用于存储服务器下载内容。|
| `$game` | 这是游戏目录。 |
| `$game/custom` | 始终添加。用于用户修改内容。 |
| `$game_hd` | 当 `fs_mount_hd` 设置为非零值时添加。用于高清内容，类似于 GoldSrc。 |
| `$game_addon` | 当 `fs_mount_addon` 设置为非零值时添加。用于用户修改内容，类似于 GoldSrc。 |
| `$game_lv` | 当 `fs_mount_lv` 设置为非零值时添加。用于低暴力内容，类似于 GoldSrc。 |
| `$game_$language` | 当 `fs_mount_l10n` 设置为非零值时添加。语言由 `ui_language` cvar 或 `-language` 命令行开关控制。用于本地化内容，类似于 GoldSrc。 |
