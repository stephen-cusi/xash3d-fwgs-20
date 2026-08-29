🌐 [English](entity-tools.md) | 🇨🇳 [中文](entity-tools.zh-CN.md)

# 实体工具

对于下面描述的一些功能，你需要在控制台中使用命令 `cmd_scripting 1` 启用[控制台脚本](https://github.com/FWGS/xash3d-fwgs/blob/master/Documentation/extensions/console-scripting.md)。
要获取更多信息，请查看与控制台脚本相关的另一个页面。

## 命令描述

### ent_create
使用指定的 classname 和键/值对创建实体。

`ent_create <classname> <key> <value> <key> <value> ...`

例如：

`ent_create monster_zombie targetname zomb1`

创建实体后，ent_last_xxx cvar 被设置为新实体，ent_last_cb 被调用，查看 ent_getvars 描述。

### ent_fire

对实体执行某些操作。

`ent_fire <pattern> <command> <args>`

#### 可用命令：

设置字段（仅设置实体字段，不调用任何函数）
* health
* gravity
* movetype
* solid
* rendermode
* rendercolor（向量）
* renderfx
* renderamt
* hullmin（向量）
* hullmax（向量）

操作
* rename：设置实体 targetname
* settarget：设置实体 target（仅 targetnames）
* setmodel：设置实体模型（不更新）
* set：通过服务器库设置键/值
    * 查看游戏 FGD 获取列表。
    * 命令接受两个参数
* touch：由当前玩家触摸实体。
* use：由当前玩家使用实体。
* movehere：将实体放置在玩家视野中。
* drop2floor：将实体放置到最近的地面
* moveup：将实体向上移动 25 个单位
* moveup（值）：沿 y 轴相对移动指定值

标志（设置/清除指定标志位，参数是位号）：
* setflag
* clearflag
* setspawnflag
* clearspawnflag

### ent_info
通过标识符打印实体信息。

`ent_info <identificator>`

### ent_getvars
设置包含实体信息的客户端 cvar（对[脚本](extensions/console-scripting.md)有用），然后调用 ent_last_cb。

`ent_getvars <identificator>`

设置的 cvar：
```
ent_last_name
ent_last_num
ent_last_inst
ent_last_origin
ent_last_class
```

### ent_list
打印按模式过滤的实体的简短信息。

`ent_list <pattern>`

## 语法描述

#### \<identificator\>
* !cross：准星下的实体
* !\<number\>\_\<serial\>：实例代码
* 由 ent_getvars 命令设置
* 实体索引
* Targetname 模式

#### \<pattern\>

模式类似于标识符，但可以按 classname 过滤多个实体。

#### （向量）

由 ent_fire 命令使用。向量表示三个浮点值，无需引号输入。

#### key/value

所有实体参数都可以通过指定键和值字符串来设置。

最初，此机制用于 map/bsp 格式，但也可以在 enttools 中使用。

键和值传递给服务器库，由实体 keyvalue 函数处理，设置 edict 和实体拥有的参数。

如果值包含空格，必须放在引号中：

`ent_fire !cross set origin "0 0 0"`

## 与脚本一起使用

ent_create 和 ent_getvars 命令在客户端设置 cvar

它可以与 ent_last_cb 别名一起使用，该别名在设置 cvar 后执行。

简单示例：

```
ent_create weapon_c4
alias ent_last_cb "ent_fire \$ent_last_inst use"
```

创建 weapon_c4 后使用它。

注意你不能同时使用多个不同的回调。

你可以通过模式设置实体名称并创建包含所有回调的特殊脚本。

示例：

> example.cfg
```
alias ent_last_cb exec entity_cb.cfg
ent create \<class\> targetname my_ent1_$name
ent_create \<class\> targetname my_ent2_$name
```
> entity_cb.cfg
```
if $ent_last_name == my_ent1_$name
:(ent1 actions)
if $ent_last_name == my_ent2_$name
:(ent2 actions)
```
注意脚本不能是阻塞的。你不能等待服务器响应然后继续。但你可以使用通过 ent_last_cb 命令连接的小脚本。最佳用途是用户交互。你可以向屏幕添加触摸按钮或通过回调调用用户命令菜单操作。

## 服务器端配置

要在服务器上启用实体工具，将 sv_enttools_enable 设置为 1

要更改 ent_fire 触及的最大实体数量，将 sv_enttools_maxfire 更改为所需数字。
