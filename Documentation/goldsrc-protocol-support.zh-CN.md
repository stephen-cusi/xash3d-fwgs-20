🌐 [English](goldsrc-protocol-support.md) | 🇨🇳 [中文](goldsrc-protocol-support.zh-CN.md)

# GoldSrc 网络协议支持
要连接到基于 GoldSrc 的服务器，请使用以下命令：
```
connect ip:port gs
```

你需要使用 [Steam API broker](https://github.com/FWGS/steam-broker) 并且你的 Steam 账户需要已购买 Half-Life 1 才能加入 GoldSrc 服务器。

Broker 将在你的 PC 上运行，负责与 Steam 客户端通信并获取认证票据。
另外，请确保通过控制台或手动编辑 `config.cfg` 文件将该 broker 设置为当前票据生成器：
```
cl_ticket_generator steam
```

如果你想从其他设备（Android/iOS 或主机）加入 GoldSrc 服务器，请确保使用 `cl_steam_broker_addr` 控制台变量设置正确的 broker IP 地址。默认值假定 broker 运行在与游戏客户端相同的设备上。

另外，我们发现一些基于 GoldSrc 的服务器会将 Xash3D 客户端识别为"假客户端"并封禁/踢出它们。也许这个问题会随着与 GoldSrc 行为的更好兼容性而得到解决，但也可能不会——我们不知道这些假客户端检查背后的逻辑。
