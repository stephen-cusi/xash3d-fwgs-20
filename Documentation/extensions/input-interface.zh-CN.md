🌐 [English](input-interface.md) | 🇨🇳 [中文](input-interface.zh-CN.md)

## 目的

客户端现在有不同平台相关的输入代码。
这很不好，因为我们无法在不同平台上使用相同的函数（除非重写几乎一半的 SDL）。

## 客户端部分

* 客户端将能够完全实现触摸输入。绘制可以通过 HUD 完成。
* 客户端将从引擎接收基本的移动和观察事件

### 客户端实现

#### 客户端将选择性地向引擎导出一些函数：
* `int IN_ClientTouchEvent ( int fingerID, float x, float y, float dx, float dy );`

如果触摸活跃返回 1，否则返回 0。

* `void IN_ClientMoveEvent ( float forwardmove, float sidemove );`

客户端将在创建命令前累积移动值，并在 CreateMove 时刷新。

* `void IN_ClientLookEvent ( float relyaw, float relpitch );`

客户端将在需要时旋转相机，就像鼠标实现一样

## 引擎部分

* 引擎将处理平台事件并调用客户端函数。
* 引擎将在客户端接口不存在时实现回退的观察和移动系统

### 引擎实现

#### 触摸事件

在调用 ClientMove 之前，引擎必须获取触摸事件。

如果客户端导出了 IN_ClientTouchEvent，事件将被发送给客户端。

否则引擎将绘制自己的触摸界面。

#### 其他事件

引擎触摸界面和操纵杆支持代码将生成两种类型的事件：
* 移动事件（IN_ClientMoveEvent 函数）
* 观察事件（IN_ClientLookEvent 函数）

如果客户端导出了这些函数，事件将在 CreateMove 之前发送给客户端
否则观察事件将在 CreateMove 之前处理，但移动事件在之后。它们将应用于生成的命令
