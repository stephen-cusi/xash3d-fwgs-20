🌐 [English](psvita.md) | 🇨🇳 [中文](psvita.zh-CN.md)

## PlayStation Vita 移植

### 前提条件
1. 确保你的 PSVita 已[设置为运行自制应用程序](https://vita.hacks.guide/)。
2. 安装 [kubridge](https://github.com/TheOfficialFloW/kubridge/releases/)。建议使用 kubridge 版本 `0.1`，因为其他版本未经测试，我们不知道它们是否合适。

   值得注意的是，我们收到报告称自动插件管理应用 EasyPlugin 在安装 kubridge 插件时有问题，因此最好手动安装：将 `kubridge.suprx` 复制到你的 taiHEN 插件文件夹（通常是 `ux0:/tai`，但可能是 `ur0:/tai`）并将其添加到你的 `config.txt`，例如：
   ```
   *KERNEL
   ux0:tai/kubridge.skprx
   ```

3. 按照[此指南](https://cimmerian.gitbook.io/vita-troubleshooting-guide/shader-compiler/extract-libshacccg.suprx)安装 `libshacccg.suprx`。

### 安装
1. 如果你有旧的 vitaXash3D 安装，请移除它。
2. 从最新的[自动构建](https://github.com/FWGS/xash3d-fwgs/releases/tag/continuous)获取 `xash3d-fwgs-psvita.7z`。
3. 将 `xash.vpk` 从 7z 归档安装到你的 PSVita 上。
4. 将 `data` 目录从 7z 归档复制到 PSVita SD 卡的根目录。
5. 将 valve 文件夹和任何其他 mod 文件夹从你的 Half-Life 安装复制到 `ux0:/data/xash3d/`（你可以使用其他挂载点代替 `ux0`）。**不要覆盖任何内容。**

### 构建说明
1. 安装 [VitaSDK](https://vitasdk.org/)。
2. 构建并安装 [vitaGL](https://github.com/Rinnegatamante/vitaGL)：
    ```
    git clone https://github.com/Rinnegatamante/vitaGL.git
    make -C vitaGL NO_TEX_COMBINER=1 HAVE_UNFLIPPED_FBOS=1 HAVE_PTHREAD=1 SINGLE_THREADED_GC=1 MATH_SPEEDHACK=1 DRAW_SPEEDHACK=1 HAVE_CUSTOM_HEAP=1 -j2 install
    ```
3. 构建并安装 [vita-rtld](https://github.com/fgsfdsfgs/vita-rtld)：
    ```
    git clone https://github.com/fgsfdsfgs/vita-rtld.git && cd vita-rtld
    mkdir build && cd build
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make -j2 install
    ```
4. 构建并安装[此 SDL2 分支](https://github.com/Northfear/SDL)（带 vitaGL 集成）：
    ```
    git clone https://github.com/Northfear/SDL.git && cd SDL
    mkdir build && cd build
    cmake -DCMAKE_TOOLCHAIN_FILE=${VITASDK}/share/vita.toolchain.cmake -DCMAKE_BUILD_TYPE=Release -DVIDEO_VITA_VGL=ON ..
    make -j2 install
    ```
5. 使用 `waf`：
    ```
    ./waf configure -T release --psvita
    ./waf build
    ```
6. 将所有生成的 `.so` 文件复制到单个文件夹：
    ```
    ./waf install --destdir=xash3d
    ```
7. `xash.vpk` 位于 `build/engine/` 中。
