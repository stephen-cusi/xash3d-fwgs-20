🌐 [English](not-supported-mod-list-and-reasons-why.md) | 🇨🇳 [中文](not-supported-mod-list-and-reasons-why.zh-CN.md)

# 不支持的 mod 及其原因

|名称|版本|不工作原因|为此做了什么
|----|-------|---------------|----------------------
|Area 51|Update 1|使用过时的 BSP31 地图格式和自定义 HLFX SDK 库。|你可以尝试[此工具](https://hlfx.ru/forum/showthread.php?threadid=5250)转换地图，但不保证能工作。
|Arrange Mod: Rebirth|v150|尚不清楚。|
|Blue Shift|最新的 Steam 版本|使用 xash3d 不支持的 vgui2 库。|在此重现源代码：https://github.com/FWGS/hlsdk-portable/tree/bshift。
|Counter Strike|Beta 6.5-|使用旧的 WON HL 1.0.0.16- 接口。|
||1.4|使用加密 blob 代替正常的 client.dll。|你可以尝试[此工具](https://aluigi.altervista.org/papers/hldlldec.zip)解密 client.dll，但不保证能工作。
||1.5|使用加密 blob 代替正常的 client.dll。|解密后的 blob 在此：https://csm.dev/threads/cs-1-5-client-dll-decrypted-patched-for-usage.38845。
||1.6（最新的 Steam 版本）|使用 xash3d 不支持的 vgui2 库。|在此进行了一些 vgui2 支持工作：https://github.com/FWGS/xash3d/tree/vinterface。在此重现客户端源代码：https://github.com/Velaron/cs16-client。
|Counter Strike: Condition Zero|最新的 Steam 版本|使用 xash3d 不支持的 vgui2 库。|在此进行了一些 vgui2 支持工作：https://github.com/FWGS/xash3d/tree/vinterface。在此重现客户端源代码：https://github.com/Velaron/cs16-client。
|Counter Strike: Condition Zero - Deleted scenes|最新的 Steam 版本|使用 xash3d 不支持的 vgui2 库。在引擎端使用了以前从未在其他 mod 中使用过的新序列代码。|在此进行了一些 vgui2 支持工作：https://github.com/FWGS/xash3d/tree/vinterface。
|Day of Defeat|最新的 Steam 版本|使用 xash3d 不支持的 vgui2 库。|在此进行了一些 vgui2 支持工作：https://github.com/FWGS/xash3d/tree/vinterface。
|Half-Life: Extended|Day One 演示版|使用许多 GoldSource 引擎钩子和版本检查。|只需等待新版本或使用更旧的版本。
|Icon of Hell|Beta 0.99|使用过时的 BSP31 地图格式和 paranoia 2 库。|你可以尝试[此工具](https://hlfx.ru/forum/showthread.php?threadid=5250)转换地图并使用 Paranoia 2: The Savior 1.51 库，但不保证能工作。
|Paranoia 2: The Savior|所有 1.51 之前的构建|使用旧的渲染器接口和引擎功能。|
|Rebellion|1.0|使用旧的 WON HL 1.0.0.16- 接口。|在此重现源代码：https://github.com/FWGS/hlsdk-portable/tree/rebellion。
|Sven-Coop|5.0+|使用自定义 GoldSource 引擎。|
|Time Shadows|Beta 0.1|使用 Direct3D 渲染器。|
