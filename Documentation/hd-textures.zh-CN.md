🌐 [English](hd-textures.md) | 🇨🇳 [中文](hd-textures.zh-CN.md)

### HD（外部）纹理支持

Xash3D 支持为游戏中几乎所有类型的模型加载 TGA 格式的纹理替换，但别名模型目前除外。

纹理应位于：
* `modfolder/materials/<mapname>` - 用于特定地图
* `modfolder/materials/common` - 所有地图通用
* `modfolder/materials/decals` - 用于贴花
* `modfolder/materials/models/<model>` - 用于模型（纹理名称必须与模型中的内部纹理名称匹配）

通过将 `host_allow_materials` cvar 设置为 `1` 或在菜单的"视频选项"部分启用高分辨率纹理支持。

#### Xash3D FWGS 附加内容

除了上述路径外，Xash3D FWGS 还检查以下路径：

* `modfolder/materials/sprites/<sprite>` - 用于精灵，但 HUD 精灵除外

另外，要检查哪些纹理替换已成功加载、失败或未找到，mod 开发者可以将 `host_allow_materials` cvar 值设置为 `2`。引擎将在任何开发者级别输出日志，格式如下：

```
Looking for <replacement> replacement... <status code> (<path relative to mod directory>)
```

状态码：
* `OK` - 纹理替换文件已找到并成功加载到 GPU 内存
* `FAIL` - 纹理文件已找到但未成功解析或加载。请参阅引擎日志获取更多详情。
* `MISS` - 未找到纹理文件

示例：
```
Looking for maps/bounce.bsp:!waterblue tex replacement...OK (materials/common/!waterblue.tga)
Looking for maps/bounce.bsp:!waterblue_luma tex replacement...MISS (not found)
Looking for {shot2 decal replacement...MISS (materials/decals/{shot2.tga)
Looking for {shot4 decal replacement...MISS (materials/decals/{shot4.tga)
Looking for {shot3 decal replacement...MISS (materials/decals/{shot3.tga)
Looking for models/gman tex replacement...FAIL (materials/models/gman/GMan_Case1.tga)
Looking for models/gman tex replacement...FAIL (materials/models/gman/inside_1.tga)
```
