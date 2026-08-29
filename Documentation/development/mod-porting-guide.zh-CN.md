🌐 [English](mod-porting-guide.md) | 🇨🇳 [中文](mod-porting-guide.zh-CN.md)

# 自制移植
## 与 RISC 架构的兼容性
### 非对齐访问
在 **i386** 上的非对齐访问仅导致性能下降，但在 **RISC** 上可能导致工作不稳定。

对于 HLSDK，至少你需要在 util.cpp 中进行这样的补丁：
 - https://github.com/FWGS/halflife/commit/7bfefe86e35d67867ae7af830ac1fc38f2908360
 - https://github.com/FWGS/hlsdk-portable/commit/617d75545f2ecb9b2d46cc30728dc37c9eb6d35e

### 有符号字符
`char` 类型在 **x86** 上定义为**有符号**，在 **arm** 上定义为**无符号**。

有时这种差异会破坏逻辑。

作为解决方案，你可以直接在代码中使用 `signed char` 类型，或对 gcc/clang 编译器使用 `-fsigned-char` 选项。

对于 HLSDK，至少你需要在 nodes.cpp/.h 中进行这样的[修复](https://github.com/FWGS/hlsdk-portable/commit/1ca34fcb4381682bd517612b530db22a1354a795)。

## 与 64 位架构的兼容性
你需要 Studio Model Render、MAKE_STRING 宏和节点的一系列补丁：
 - https://github.com/FWGS/hlsdk-portable/commit/d287ed446332e615ab5fb25ca81b99fa14d18a73
 - https://github.com/FWGS/hlsdk-portable/commit/3bce17e3a04f8af10a927a07ceb8ab0f09152ec4
 - https://github.com/FWGS/hlsdk-portable/commit/9ebfc981773ec4c7a89ffe52d9c249e1fbef9634
 - https://github.com/FWGS/hlsdk-portable/commit/00833188dab87ef5746286479ba5aeb9d83b4a0c
 - https://github.com/FWGS/hlsdk-portable/commit/4661b5c1a5245b27a5532745c11e44b5540e4172
 - https://github.com/FWGS/hlsdk-portable/commit/2b61380146b1d58a8c465f0e312c061b12bda115
 - https://github.com/FWGS/hlsdk-portable/commit/8ef6cb2427ee16a763103bd3f315f38e2f01cfe2

## Mobility API
Xash3D FWGS 在 `mobility_int.h` 中有特殊的扩展接口，添加了一些新功能，如移动平台上的振动。

## 移植服务器端代码
原始 Valve 的服务器代码与 Linux 和 gcc 2.x 兼容。

较新的 gcc 版本有限制，会破坏构建。

现在，要使它能用 gcc 4.x+ 或 clang 构建，你需要做以下操作：
* 转到 cbase.h 并按如下方式重新定义宏
```
#define SetThink( a ) m_pfnThink = static_cast <void (CBaseEntity::*)(void)> (&a)
#define SetTouch( a ) m_pfnTouch = static_cast <void (CBaseEntity::*)(CBaseEntity *)> (&a)
#define SetUse( a ) m_pfnUse = static_cast <void (CBaseEntity::*)( CBaseEntity *pActivator, CBaseEntity *pCaller, USE_TYPE useType, float value )> (&a)
#define SetBlocked( a ) m_pfnBlocked = static_cast <void (CBaseEntity::*)(CBaseEntity *)> (&a)
#define ResetThink( ) m_pfnThink = static_cast <void (CBaseEntity::*)(void)> (NULL)
#define ResetTouch( ) m_pfnTouch = static_cast <void (CBaseEntity::*)(CBaseEntity *)> (NULL)
#define ResetUse( ) m_pfnUse = static_cast <void (CBaseEntity::*)( CBaseEntity *pActivator, CBaseEntity *pCaller, USE_TYPE useType, float value )> (NULL)
#define ResetBlocked( ) m_pfnBlocked = static_cast <void (CBaseEntity::*)(CBaseEntity *)> (NULL)
...
#define SetMoveDone( a ) m_pfnCallWhenMoveDone = static_cast <void (CBaseToggle::*)(void)> (&a)
```
* 将所有 SetThink(NULL)、SetTouch(NULL)、setUse(NULL) 和 SetBlocked(NULL) 替换为 ResetThink()、ResetTouch()、ResetUse() 和 ResetBlocked()
* 有时你可能需要添加 #include <ctype.h>，如果缺少 tolower 或 isspace 函数

## 移植客户端代码

* 将所有 DLLEXPORT 定义重新定义为空字段（如果你要保持 Windows 兼容性，将其放在 _WIN32 宏下）。
* 从 hud.cpp 中移除 hud_servers.cpp 和 Servers_Init/Servers_Shutdown。
* 修复 include 中的 CAPS 文件名（如 STDIO.H，替换为 stdio.h）。
* 用我们的 hlsdk-portable 移植中的修复示例替换损坏的宏 DECLARE_MESSAGE、DECLARE_COMMAND（cl_util.h）。
* 在需要的地方添加 ctype.h（tolower、isspace 函数）。
* 在需要的地方添加 string.h（memcpy、strcpy 等）。
* 使用 hlsdk-portable 中的 in_defs.h。
* 添加 hlsdk-portable 项目中的 input_xash3d.cpp 以修复输入。

现在你的客户端应该能够正确构建和工作。

# 将 mod 移植到 hlsdk-portable
查看所做的更改。

如果更改不多（例如，只添加了一些武器），将这些更改添加到 hlsdk-portable 中。

你可以使用与原始 HLSDK 的 diff 并将其作为补丁应用到 hlsdk-portable。

```
注意：许多旧 mod 是在 HLSDK 2.0-2.1 上制作的，一些罕见的 mod 在 HLSDK 1.0 上。
因此你需要不同版本的 HLSDK 来制作 diff。
另外如果 mod 是在 Spirit of Half-Life 上制作的，还需要不同版本的 Spirit of Half-Life。
此外，旧 HLSDK 版本中的武器不使用客户端武器预测系统，你可能需要将标准 Half-Life 武器移植到服务器端。
```
文件必须具有相同的行尾（对所有文件使用 dos2unix）。

我们建议在 diff 中启用忽略空格更改。

将所有新文件移动到单独的目录中。

# 可移植外部依赖的可能替代品
1. 如果 mod 使用 **fmod.dll** 或 **base.dll** 在客户端播放 mp3/ogg 或在服务器端预缓存声音，你可以用以下替代：
	- [pfnPrimeMusicStream](https://github.com/FWGS/hlsdk-portable/blob/master/engine/cdll_int.h#L293=) 引擎回调；
	- [miniaudio](https://github.com/mackron/miniaudio)；
	- [phonon](https://community.kde.org/Phonon)。

2. 如果 mod 使用 **OpenGL**，建议将代码移植到 Xash3D 渲染接口。

3. 如果 mod 使用 **cg.dll**，你可以尝试将代码移植到 [NVFX](https://github.com/tlorach/nvFX)。

4. 如果 mod 使用 detours，注释代码或尝试自行找到替代品。

# 附加建议
1. 如果 mod 使用 STL，你可以用 [MiniUTL](https://github.com/FWGS/MiniUTL) 替代。
2. 避免使用动态转换以生成小型二进制文件。
3. 避免使用异常以生成小型二进制文件。
 
# 编写构建脚本

使用 hlsdk-portable 中的 wscript/CMakeLists.txt 文件作为构建脚本示例。

从 Visual Studio 项目获取 .c 和 .cpp 文件列表。

添加缺失的包含目录。
