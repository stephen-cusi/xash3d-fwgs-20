🌐 [English](touch-controls.md) | 🇨🇳 [中文](touch-controls.zh-CN.md)

# 触摸控制配置

## 简介

感谢 mittorn，我们能够在 Xash3D 中完全自定义控制。新配置不仅允许你添加和更改控制按钮，还可以创建自定义菜单。还有一个内置的可视化编辑器，简化了自定义过程，无需手动编辑文件。

## 编辑器模式使用

1. 启动 Xash3D 并开始游戏。
2. 要进入编辑模式，点击齿轮图标（命令 `touch_enableedit`）。
3. 在编辑模式下，会显示网格。网格数量可以通过命令 `touch_grid_count` 更改（默认为 50）。可以通过命令 `touch_grid_enable 0` 禁用网格。

*触摸控制布局编辑器*
![](images/editor.jpg)

*触摸配置文件窗口*
![](images/touch-profiles.jpg)

*触摸按钮参数窗口*
![](images/touch-buttons.jpg)

## 布局编辑器功能

* **移动按钮**：点击按钮，拖动到所需位置，然后释放。
* **调整按钮大小**：将第一根手指放在按钮的左上角，用第二根手指调整大小。
* **隐藏/显示按钮**：选择按钮（会变红），然后使用菜单：
    * **Close**：关闭编辑模式（`touch_disableedit`）。
    * **Reset**：将按钮重置为默认值。
    * **Hide/Show**：隐藏或显示按钮（`touch_hide <name>` / `touch_show <name>`）。

## 使用配置文件 / 控制台

在可视化编辑器中所做的所有更改都会自动保存到触摸配置文件中。文件位于游戏目录内的 `touch_profiles` 文件夹中。文件名取决于所选的配置文件。

### 配置文件中的常用命令

```
// 注释：以 // 开头的行会被忽略。

// 移动的滑动区域。指定需要滑动多远才能加速。
// 默认值设置为适合小滑动即可立即快速行走的最优值。
touch_forwardzone "0.060000" ; touch_sidezone "0.060000"

// 灵敏度设置（pitch - 水平，yaw - 垂直）。
touch_pitch ; touch_yaw

// 网格设置（见上文）。
touch_grid_count ; touch_grid_enable

// 在按钮周围绘制边框。
touch_set_stroke <thickness> <c> <v> <e> <t>
(<r> - 红色；<g> - 绿色；<b> - 蓝色；<a> - alpha/透明度）

// 显示 (1) 或隐藏 (0) 客户端按钮。
touch_setclientonly

// 从屏幕上移除所有按钮。
touch_removeall

// 显示配置文件中所有可用按钮。
touch_list

// 编辑后保存配置。你可以指定新的文件名。
touch_config_file command.cfg
```

*标准 `touch.cfg` 文件中的完整按钮列表，在控制台中使用 `touch_list` 时显示。*
![](images/example2.jpg)


## 添加新按钮

要添加新按钮，请使用控制台命令：

```
touch_addbutton "digits" "touch/key_1.png" "toggle_digits" 0.340000 0.782222 0.400000 0.888889 255 255 255 100 0
```

### `touch_addbutton` 命令的参数

| 参数 | 描述 |
| --- | --- |
| `"digits"` | 按钮的唯一名称。 |
| `"touch/key_1.png"` | 图标文件路径（`.png` 格式）。如果不需要图标，留空 `""`。 |
| `"toggle_digits"` | 点击后执行的命令（例如，`"buy"` 用于购买）。 |
| `0.340000` | 按钮左上角的 X 坐标。 |
| `0.782222` | 按钮左上角的 Y 坐标。 |
| `0.400000` | 按钮右下角的 X 坐标。 |
| `0.888889` | 按钮右下角的 Y 坐标。 |
| `255 255 255` | RGB 格式的按钮颜色。 |
| `100` | 按钮透明度（0 - 完全透明，255 - 完全不透明）。 |
| `0` | 标志（见下一节）。 |

## 标志列表

标志定义按钮的行为。它们的值是 2 的幂：

| 标志 | 值 | 描述 |
| --- | --- | --- |
| `TOUCH_FL_HIDE` | 1 | 隐藏按钮（游戏中不显示，但在编辑器中可见）。 |
| `TOUCH_FL_NOEDIT` | 2 | 禁止在编辑器中编辑按钮。 |
| `TOUCH_FL_CLIENT` | 4 | 按钮是客户端的（不保存在主控制文件中）。 |
| `TOUCH_FL_MP` | 8 | 按钮仅在多人游戏中显示。 |
| `TOUCH_FL_SP` | 16 | 按钮仅在单人游戏中显示。 |
| `TOUCH_FL_DEF_SHOW` | 32 | 按钮在启动时始终显示。 |
| `TOUCH_FL_DEF_HIDE` | 64 | 按钮在启动时始终隐藏。 |
| `TOUCH_FL_DRAW_ADDITIVE` | 128 | 按钮颜色在混合模式下相加。 |
| `TOUCH_FL_STROKE` | 256 | 启用按钮周围的轮廓描边。 |

标志可以通过将它们的值相加来组合。例如，`5 = 1 + 4` 是 `TOUCH_FL_HIDE` 和 `TOUCH_FL_CLIENT` 标志的组合，即隐藏的客户端按钮。

*在下图中，`spray`、`scores`、`messagemode` 按钮同时显示，标志为 8，`loadquick`、`savequick` 标志为 16，每个都在对应的游戏模式中显示。*
![](images/example1.jpg)

## 有用命令

* `touch_hide <pattern>`：按模式隐藏按钮。
* `touch_setcommand`：更改绑定到按钮的命令。
* `touch_settexture`：快速更改按钮图像。
* `touch_setcolor`：设置按钮颜色。
* `touch_exportconfig`：导出当前配置，包括宽高比。

## 使用示例

* `touch_hide menu*` 隐藏所有名称以 `menu` 开头的按钮。
* `touch_setcolor "attack" 255 160 0 128` 将主射击按钮的颜色从不透明白色更改为半透明橙色，类似于 Half-Life 中 HUD 的颜色。

    *执行此命令的结果*
    ![](images/example3.jpg)

* 添加带有自定义图标的新按钮的示例（使用 `lastinv` 命令 - 快速切换武器）
    ![](images/example4.jpg)

    *此按钮在布局编辑器中的视图*
    ![](images/example5.jpg)

## 提示

* 为防止 `look` 和 `move` 按钮干扰编辑其他元素，请在配置文件中将它们放在其他按钮之前。
* 反之，要使按钮显示在其他按钮之上，请将其放在配置文件的末尾。
* 你可以为按钮分配更改其他按钮的命令，参见上一节"使用示例"。
* 在触摸按钮部分编辑每个单独按钮的每个参数后，不要忘记按保存，否则应用的参数将不会被保存。
* 要为按钮创建自己的图标，你可以使用任何图形编辑器（对于 Android，iudesk 的 Photo Editor 很合适）。保存条件：
    * 图像格式 - 带透明度的 `.png`（例如 alpha 通道）
    * 宽高比 / 大小 - 1:1 / 256x256
    * 图标位置路径 - 游戏目录内的 `touch/gfx`。
    
### 附加链接
* [用于选择 RGB 格式颜色的便捷调色板](https://www.rapidtables.com/web/color/RGB_Color.html)
