🌐 [English](native-object.md) | 🇨🇳 [中文](native-object.zh-CN.md)

# GetNativeObject API

为了能够使用平台特定功能或获取可选的引擎接口，我们为客户端 DLL 添加了简单的 MobilityAPI 调用，为服务器 DLL 添加了 PhysicsAPI，为菜单 DLL 扩展了 MenuAPI。

定义如下：

```
void *pfnGetNativeObject( const char *name );
```

#### 跨平台对象

只有这些对象保证在所有目标平台上可用。

| 对象名称 | 接口 |
|-------------|-----------|
| `VFileSystem009` | 提供文件系统的 C++ 接口，与 Valve 的 VFileSystem009 二进制兼容。 |
| `XashFileSystemXXX` | 提供文件系统的 C 接口。此接口不稳定，不建议在引擎内部之外的通用使用中使用。有关当前版本的更多信息，请查看 `filesystem.h`。 |
| `MenuFactory` | 返回当前加载的菜单库的 `CreateInterface` 函数指针（`pfnCreateInterface_t`）。 |

#### Android 特定对象

| 对象名称 | 接口 |
|-------------|-----------|
| `JNIEnv` | 允许与 Java Native Interface 交互。 |
| `ActivityClass` | 返回引擎 Android activity 类的 JNI 对象。 |
