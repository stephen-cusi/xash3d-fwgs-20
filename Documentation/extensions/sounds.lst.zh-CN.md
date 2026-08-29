🌐 [English](sounds.lst.md) | 🇨🇳 [中文](sounds.lst.zh-CN.md)

# sounds.lst.md

使用位于 scripts 文件夹中的 sounds.lst，mod 作者可以覆盖临时实体和服务器物理中的一些硬编码声音。

文件格式：
```
<group name>
{
	<path1>
	<path2>
	<path3>
}

<group2 name> <path with %d> <min number> <max number>
```

* 声音可以使用任何支持的声音格式（WAV 或 MP3）。
* 路径必须相对于游戏或基础目录根目录的 sounds/ 文件夹、附加文件夹或归档根目录。
* 组可以为空或从文件中省略以不加载任何声音。
* 组可以列出一组文件或指定格式字符串和范围。
* `//` 之后的任何内容将被视为注释并被忽略。
* 如果组被多次列出，行为未定义。

当前支持的组：
|组名称|用途|
|----------|-----|
|`BouncePlayerShell`|用于 BOUNCE_SHELL 临时实体命中音效|
|`BounceWeaponShell`|用于 BOUCNE_SHOTSHELL 临时实体命中音效|
|`BounceConcrete`|用于 BOUNCE_CONCRETE 临时实体命中音效|
|`BounceGlass`|用于 BOUCNE_GLASS|
|`BounceMetal`|用于 BOUNCE_METAL|
|`BounceFlesh`|用于 BOUNCE_FLESH|
|`BounceWood`|用于 BOUNCE_WOOD|
|`Ricochet`|用于 BOUNCE_SHRAP 和跳弹临时实体|
|`Explode`|用于临时实体爆炸|
|`EntityWaterEnter`|用于实体进入水中|
|`EntityWaterExit`|用于实体离开水中|
|`PlayerWaterEnter`|用于玩家进入水中|
|`PlayerWaterExit`|用于玩家离开水中|

## 示例

此示例基于 Half-Life 中使用的默认声音：

```
BouncePlayerShell "player/pl_shell%d.wav" 1 3
BounceWeaponShell "weapons/sshell%d.wav" 1 3
BounceConcrete "debris/concrete%d.wav" 1 3
BounceGlass "debris/glass%d.wav" 1 4
BounceMetal "debris/metal%d.wav" 1 6
BounceFlesh "debris/flesh%d.wav" 1 7
BounceWood "debris/wood%d.wav" 1 4
Ricochet "weapons/ric%d.wav" 1 5
Explode "weapons/explode%d.wav" 3 5
EntityWaterEnter "player/pl_wade%d.wav" 1 4
EntityWaterExit "player/pl_wade%d.wav" 1 4
PlayerWaterEnter
{
	"player/pl_wade1.wav"
}
PlayerWaterExit
{
	"player/pl_wade2.wav"
}
```
