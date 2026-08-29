🌐 [English](environment-variables.md) | 🇨🇳 [中文](environment-variables.zh-CN.md)

## 环境变量

#### Xash3D FWGS

引擎会读取以下环境变量：

| 变量 | 类型 | 描述 |
| --------------------- | ---------- | ----------- |
| `XASH3D_GAME` | _string_ | 覆盖默认游戏目录。如果设置了 `-game` 命令行参数则忽略此变量 |
| `XASH3D_BASEDIR` | _string_ | 设置基础（根）目录路径，替代当前工作目录 |
| `XASH3D_RODIR` | _string_ | 设置只读基础（根）目录路径。如果设置了 `-rodir` 命令行参数则忽略此变量 |
| `XASH3D_EXTRAS_PAK1` | _string_ | 指定路径的归档文件将被添加到虚拟文件系统搜索路径中，优先级最低 |
| `XASH3D_EXTRAS_PAK2` | _string_ | 类似 `XASH3D_EXTRAS_PAK1`，但在优先级列表中紧邻其后 |

上表中未列出的环境变量为内部使用，不被视为稳定接口。

#### mdldec

| 变量 | 类型 | 描述 |
| --------------------- | ---------- | ----------- |
| `MDLDEC_ACT_PATH` | _string_ | 如果设置，将从此路径读取活动列表 |
