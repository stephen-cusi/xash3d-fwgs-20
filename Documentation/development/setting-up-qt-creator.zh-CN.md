🌐 [English](setting-up-qt-creator.md) | 🇨🇳 [中文](setting-up-qt-creator.zh-CN.md)

## 在 Qt Creator 中设置 Xash3D FWGS

### 简介

大多数版本的 Qt Creator 支持使用 `compile_commands.json` 作为项目文件，Waf 支持以兼容格式生成此文件。在本教程中我们将利用这些功能。

本教程使用 Qt Creator 18.0 编写，但我建议你使用可用的最新 Qt Creator 版本，因为它通常有重要的 bug 修复。

### 步骤 1. 配置构建。

`compile_commands.json` 文件，顾名思义，包含在构建期间调用编译器时使用的每条命令。由于构建过程取决于构建配置，我们必须先配置它。我不打算在这里详细说明，因为编译 Xash3D FWGS 的基础知识已经在仓库根目录的 `README.md` 中解释过了。

将配置步骤命令保存在某处，因为稍后会用到。

### 步骤 2. 生成 `compile_commands.json` 文件。

通常，此文件在成功构建后位于 `build` 目录中。但是，也可以通过运行以下命令手动生成：

在 *nix 系统上：

```
$ ./waf clangdb
```

或在 Windows 上：

```
> waf.bat clangdb
```

### 步骤 3. 在 Qt Creator 中加载项目。

为此，你需要确保启用了 `Compilation Databases` 插件。由于它被认为是实验性的，可能需要手动启用。可以在 `Help` -> `About Plugins...` 中完成。在 `Build Systems` 类别中找到它，勾选复选框并按 `OK`。IDE 将要求重启，所以请执行。

IDE 重启后，你可以使用 `File` -> `Open File or Project...`。导航到 Xash3D FWGS 目录，然后到 `build` 目录并选择 `compile_commands.json` 文件。如果一切正确，IDE 将要求设置项目。按 `Configure Project` 按钮，因为大多数选项通常不适用于我们。

接下来 IDE 将显示项目树，但你可能看不到任何文件。这是因为 Qt Creator "认为"我们的项目根目录位于 `build` 目录中。幸运的是它提供了覆盖此设置的方法。要修复它，在项目树根部（通常称为类似 `build [master]` 的名称）点击鼠标右键并选择 `Change Root Directory`。在打开的窗口中选择 Xash3D FWGS 仓库根目录并按 `OK`。

### 步骤 4. 告诉 IDE 如何构建此项目。

打开左侧菜单中的 `Projects` 并选择 `Build Settings` 选项卡。你应该看到构建和清理步骤的空配置。按 `Add Build Step` 按钮并选择 `Custom Process Step`。

在创建的步骤中，你应该看到 `Command`、`Arguments` 和 `Working Directory`。

对于命令，选择 Python 可执行文件。对于参数，使用第一步中 Waf 的 configure 命令。工作目录通常由 IDE 设置为 `%{buildDir}`。你需要选择上级目录，即 `waf` 所在的位置。为节省时间，可以指定为 `%{buildDir}/../`。

添加另一个自定义步骤，填充相同的命令和工作目录。对于参数使用 `waf build`。

在下方你应该看到 `Clean steps`。以相同方式创建清理步骤，填充参数和工作目录，对于参数使用 `waf clean`。

### 步骤 5. 告诉 IDE 如何复制构建的二进制文件。

现在选择 `Deploy Settings` 选项卡。按 `Add Deploy Step` -> `Custom Process Step`。同样，相同的命令和工作目录。在参数字段中输入：`waf install --destdir="<这里放入 Xash 二进制文件应复制到的位置>"`。

### 步骤 6. 最后，设置 Qt Creator 运行引擎。

选择 `Run Settings` 选项卡。在下方你可能看到熟悉的文本字段：`Executable`、`Command line arguments` 和 `Working directory`。

对于工作目录，点击 `Browse...` 按钮并选择 Xash3D 可执行文件将被复制到的文件夹（来自上一步）。

对于可执行文件，在 *nix 上输入 `./xash3d`，在 Windows 上输入 `xash3d.exe`。命令行参数与你运行引擎时使用的相同。也可以为空，但我个人使用 `-dev 2 -log` 以获得额外的详细输出。

### 结束语

此时，你应该能够按 `Run` 按钮，等待构建完成并看到正在运行的 Xash3D FWGS。在 Windows 上使用调试器，你可能需要 `CDB` 调试器和相应的 `qtcreatorcdbext` 二进制文件来调试 32 位应用程序，64 位需要单独的版本，但这留作读者的练习和此文档的潜在改进。
