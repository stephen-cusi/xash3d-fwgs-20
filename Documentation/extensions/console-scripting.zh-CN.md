🌐 [English](console-scripting.md) | 🇨🇳 [中文](console-scripting.zh-CN.md)

## 控制台变量

控制台变量（或 CVars）存在于所有基于 Quake 的游戏中。

默认情况下，它们是引擎、服务器或客户端库创建的设置。

但你可以使用 `set` 命令定义变量，即使它们不是由引擎创建的。

例如，你可以在代码中注册 cvar 之前设置它。

`set defaultmap crossfire`

这甚至可以在 server.cfg 中服务器 cvar 初始化之前工作，引擎会在创建 cvar 时重用其值

## 别名

别名允许定义新命令。

`alias wnext "invnext;wait;wait;+attack;wait;-attack"`

你可以通过添加别名来钩住任何命令，并在需要使用原始命令时取消别名。

```
alias invnext1 "unalias invnext;wnext;alias invnext invnext1"
alias invnext invnext1
```

## 脚本扩展

这是 Xash3D FWGS 的扩展（自构建 3887 起合并到原始 Xash3D 中），可以通过 cmd_scripting cvar 启用。

启用脚本：`cmd_scripting 1`

这是一个归档 cvar，会被保存。

### CVar 替换

你可以通过添加 \$ 符号将 cvar 值替换到任何命令中：

`echo $sv_cheats`

### 条件检查

允许检查 cvar 值。

```
if <value1> <operator> <value2>
:<action1>
:if <value3>
::<action2>
:<action3>
else
:<action4>
```

* 值可以是任何字符串或数值（例如，替换的 cvar）。
* 运算符是 =（或 ==）、\!=、\<、\>、\<=、\>=。== 与 = 相同。
* 如果只指定一个值，当值为非零时条件为真

示例：

```
if $sv_cheats == 1
:echo Cheats enabled, adding cheat menu
:exec cheatmenu.cfg
else
:echo Please enable cheats to use this!
```
