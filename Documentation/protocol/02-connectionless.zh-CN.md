🌐 [English](02-connectionless.md) | 🇨🇳 [中文](02-connectionless.zh-CN.md)

# Xash3D 49 无连接协议

无连接协议定义了四种常见的消息源和目的地，它们可以是：
* `S` 表示服务器
* `C` 表示客户端
* `M` 表示主服务器
* `A` 表示其他

所有无连接数据包的头部都有 `\xff\xff\xff\xff`（32 位整数全设为 1）。让我们在本文档中逐一介绍每个可能的方向。

<!--TOC-->

- [任意](#任意)
  - [任意到任意](#任意到任意)
    - [`A2A_PING` 和 `A2A_GOLDSRC_PING`](#a2a_ping-和-a2a_goldsrc_ping)
    - [`A2A_ACK` 和 `A2A_GOLDSRC_ACK`](#a2a_ack-和-a2a_goldsrc_ack)
    - [已弃用的查询](#已弃用的查询)
      - [`A2A_NETINFO`](#a2a_netinfo)
      - [`A2A_INFO`](#a2a_info)
  - [任意到客户端](#任意到客户端)
    - [`A2C_PRINT` 和 `A2C_GOLDSRC_PRINT`](#a2c_print-和-a2c_goldsrc_print)
  - [任意到服务器和服务器到任意](#任意到服务器和服务器到任意)
    - [GoldSrc 服务器查询](#goldsrc-服务器查询)
    - [`A2S_GOLDSRC_INFO`](#a2s_goldsrc_info)
    - [`A2S_GOLDSRC_PLAYERS`](#a2s_goldsrc_players)
    - [`A2S_GOLDSRC_RULES`](#a2s_goldsrc_rules)
  - [任意到主服务器](#任意到主服务器)
    - [`S2M_SCAN_REQUEST`](#s2m_scan_request)
  - [主服务器到任意](#主服务器到任意)
    - [`M2A_SERVERSLIST`](#m2a_serverslist)
- [主服务器和游戏服务器](#主服务器和游戏服务器)
  - [服务器到主服务器](#服务器到主服务器)
    - [`S2M_HEARTBEAT`](#s2m_heartbeat)
    - [`S2M_SHUTDOWN`](#s2m_shutdown)
    - [`S2M_INFO`](#s2m_info)
  - [主服务器到服务器](#主服务器到服务器)
    - [`M2S_CHALLENGE`](#m2s_challenge)
    - [`M2S_NAT_CONNECT`](#m2s_nat_connect)
- [客户端和游戏服务器](#客户端和游戏服务器)
  - [客户端到服务器](#客户端到服务器)
    - [`C2S_BANDWIDTHTEST`](#c2s_bandwidthtest)
    - [`C2S_GETCHALLENGE`](#c2s_getchallenge)
    - [`C2S_CONNECT`](#c2s_connect)
  - [服务器到客户端](#服务器到客户端)
    - [`S2C_BANDWIDTHTEST`](#s2c_bandwidthtest)
    - [`S2C_CHALLENGE`](#s2c_challenge)
    - [`S2C_CONNECTION`](#s2c_connection)
    - [`S2C_ERRORMSG`](#s2c_errormsg)
    - [`S2C_REJECT`](#s2c_reject)

<!--TOC-->

## 任意

### 任意到任意

#### `A2A_PING` 和 `A2A_GOLDSRC_PING`

简单的 ping 消息。
* 请求，ASCII 格式：`ping` 或 GoldSrc 格式的 `i`
* 响应始终是 `A2A_ACK` 或 `A2A_GOLDSRC_ACK`

#### `A2A_ACK` 和 `A2A_GOLDSRC_ACK`

简单的确认消息。
* 请求，ASCII 格式：`ack` 或 GoldSrc 格式的 `j`
* 响应：无

#### 已弃用的查询

这些基于文本的 Xash 协议查询已被 [GoldSrc 服务器查询](#goldsrc-服务器查询)取代，Xash3D FWGS 服务器也实现了这些查询。新实现不得发送它们。服务器仍然响应 `A2A_INFO` 以兼容旧客户端，`A2A_NETINFO` 不再处理。

##### `A2A_NETINFO`

用于实现 Half-Life 的 NetAPI。
* 请求消息，ASCII 格式：`netinfo <version> <context> <request_id>`
  - `version` 必须是 49，作为文本。
  - `context` 可以是任何 32 位有符号整数值，编码为文本。
  - `request_id` 参见 `common/net_api.h`

* 响应消息，ASCII 格式：`netinfo <context> <request_id> <response>`
  - `context` 与请求中相同。
  - `request_id` 与请求中相同。
  - `response` 是服务器的响应，取决于请求类型。始终编码为 Quake 信息字符串。

可能的请求和响应格式：
* 请求 ID `1` 将使服务器响应空响应字符串。
* 请求 ID `2` 使服务器响应所有服务器游戏规则 cvar，其中键是 cvar 名称，值是 cvar 值。添加一个额外的键 `rules`，值为 cvar 总数。
* 请求 ID `3` 使服务器响应玩家列表，其中：
  - `p<id>name` 设置为玩家名称
  - `p<id>frags` 设置为玩家击杀数
  - `p<id>time` 设置为玩家总游戏时间
  - `players` 是总玩家列表。
  - 或者，如果服务器不愿暴露玩家列表，可以响应 `neterror` 设为 `forbidden`。
* 请求 ID `4` 使服务器响应通用游戏详情：
  - `hostname` 是服务器名称
  - `gamedir` 是游戏目录名称
  - `current` 是总玩家数
  - `max` 是最大玩家限制
  - `map` 是服务器当前关卡
* 对于任何其他请求，服务器将响应 `neterror` 设为 `undefined`
* 如果协议版本不匹配，服务器响应 `neterror` 设为 `protocol`

##### `A2A_INFO`

用于请求服务器详情。
* 请求消息，ASCII 格式：`info <version>`
  - `version` 必须是 49，作为文本
* 响应消息，ASCII 格式：`info\n<response>`
  - `response` 是 Quake 信息字符串，否则是错误消息。

* 响应信息字符串格式：
  - `p` 设置为协议版本（FWGS 扩展）
  - `map` 是服务器当前关卡
  - `dm` 当前游戏模式是死亡竞赛时设为 1，否则为 0
  - `team` 当前游戏模式包含团队游戏时设为 1，否则为 0
  - `coop` 当前游戏模式是合作模式时设为 1，否则为 0
  - `numcl` 是总玩家数
  - `maxcl` 是最大玩家限制
  - `gamedir` 是游戏目录名称
  - `password` 服务器有密码保护时设为 1，否则为 0
  - `host` 是服务器名称

### 任意到客户端

#### `A2C_PRINT` 和 `A2C_GOLDSRC_PRINT`

简单的打印消息。
* 头部：`\xff\xff\xff\xff`
* 请求，ASCII 格式：`print <message>` 或 GoldSrc 格式的 `l<message>`。
* 响应：无

### 任意到服务器和服务器到任意

#### GoldSrc 服务器查询

这些与 GoldSrc 和 Source 引擎中使用的 Source Engine Query 消息匹配，为兼容现有服务器浏览器和监控工具而实现。客户端在服务器浏览器中使用它们查询 GoldSrc 服务器，并且由于基于文本的 Xash 协议查询已[弃用](#已弃用的查询)，它也将使用它们查询 Xash 服务器。在 VDC 上阅读它们的文档：https://developer.valvesoftware.com/wiki/Server_queries

与其他无连接消息不同，这些是二进制的：整数是小端序，浮点数是 32 位 IEEE 754，字符串以空字符结尾。

`A2S_GOLDSRC_PLAYERS` 和 `A2S_GOLDSRC_RULES` 请求携带 32 位挑战值，`A2S_GOLDSRC_INFO` 可以在查询字符串后附加一个。当尚不知道挑战值时，发送 `\xff\xff\xff\xff` 代替。服务器可能响应挑战而不是数据：字节 `A`（`0x41`）后跟 32 位挑战值，连同头部共 9 字节。然后使用收到的挑战重复请求。不要将此消息与连接期间使用的文本 `S2C_GOLDSRC_CHALLENGE` 混淆，它们只共享第一个字节。

不适合单个数据包的响应（通常是规则）从 GoldSrc 服务器分片发送。此类数据包以 `\xfe\xff\xff\xff` 开头而不是 `\xff\xff\xff\xff`，后跟 32 位序列号（同一响应的所有分片中相同），以及一个字节，低 4 位是总分片数，高 4 位是此分片的索引。按索引顺序连接的分片有效载荷形成正常的 `\xff\xff\xff\xff` 消息。Xash 服务器从不分片查询响应，而是作为单个数据报发送。

#### `A2S_GOLDSRC_INFO`

用于请求服务器详情。

* 请求：`TSource Engine Query\0`，可选后跟 32 位挑战值。Xash 服务器忽略它。
* 响应：字节 `I`（`S2A_GOLDSRC_INFO`），后跟：
  - 字节：协议版本，GoldSrc 上为 48，Xash3D FWGS 上为 49
  - 字符串：服务器名称
  - 字符串：服务器当前关卡
  - 字符串：游戏目录名称
  - 字符串：游戏描述
  - int16：Steam AppID，Xash 服务器上始终为 0
  - 字节：总玩家数，包含机器人
  - 字节：最大玩家限制
  - 字节：机器人数量
  - 字节：服务器类型，`d` 表示专用服务器，`l` 表示监听服务器
  - 字节：服务器操作系统，`w` 表示 Windows，`l` 表示 Linux，`m` 表示 macOS
  - 字节：服务器有密码保护时设为 1，否则为 0
  - 字节：服务器有 VAC 保护时设为 1，Xash 服务器在此处放置 gameinfo 中的 `secure` 值
  - 字符串：服务器版本

与 Source 引擎响应格式相同，但没有额外数据标志及其字段。

旧版 GoldSrc 服务器响应过时的 `m` 格式（`S2A_GOLDSRC_LEGACY_INFO`），其布局参见 VDC。Xash 服务器从不发送它，但客户端理解它并假定协议 48。

#### `A2S_GOLDSRC_PLAYERS`

用于请求服务器的玩家列表。

* 请求：字节 `U`（`0x55`），然后是 32 位挑战值。
* 响应：字节 `D`（`S2A_GOLDSRC_PLAYERS`），后跟一个字节的总玩家数，然后对每个玩家：
  - 字节：玩家索引。Xash 服务器发送从 0 开始的顺序索引，GoldSrc 服务器始终在此处发送 0。
  - 字符串：玩家名称
  - int32：玩家击杀数
  - float：玩家连接的秒数，Xash 服务器上机器人为 -1.0

如果玩家列表为空、服务器有密码保护或通过 `sv_expose_player_list` cvar 禁用了玩家列表暴露，Xash 服务器完全不响应。

#### `A2S_GOLDSRC_RULES`

用于请求服务器的游戏规则。

* 请求：字节 `V`（`0x56`），然后是 32 位挑战值。
* 响应：字节 `E`（`S2A_GOLDSRC_RULES`），后跟一个 int16 的总规则数，然后是每个规则的名称和值字符串。

仅发送服务器 cvar（`FCVAR_SERVER`）。受保护 cvar（`FCVAR_PROTECTED`）的值在设置了值时替换为 `1`，否则为 `0`。如果没有要暴露的 cvar，服务器完全不响应。

### 任意到主服务器

#### `S2M_SCAN_REQUEST`

* 请求：`1<region><IP:Port>\0<info>`
  - 此消息的格式大致基于 https://developer.valvesoftware.com/wiki/Master_Server_Query_Protocol
  - `info` 但添加了几个额外字段：
    - `clver` 设置为引擎版本
    - `nat` 设为 1 以仅过滤 NAT 后面的服务器并通知主服务器通知服务器有关扫描的信息
    - `commit` 设置为引擎构建提交哈希
    - `branch` 设置为引擎构建分支
    - `os` 设置为引擎构建的操作系统
    - `arch` 设置为引擎构建的 CPU 架构
    - `buildnum` 设置为引擎构建号
    - `key` 设置为随机 32 位值，格式为十六进制，用于验证主服务器响应
* 响应：`M2A_SERVERSLIST`

### 主服务器到任意

#### `M2A_SERVERSLIST`

* 请求：`f\xff<key><reserved><IP:Port>...`
  - `key` 是在 `S2M_SCAN_REQUEST` 中设置的随机 32 位值
  - `reserved` 是单个保留 8 位字节
  - 后面是二进制形式的 IP 地址列表：IPv4 地址 + 端口 6 字节，IPv6 地址 + 端口 18 字节
  - 如果端口为 0，表示列表结束，否则它是用于分页的最后一个 IP（Xash3D 中未实现）
* 响应：客户端不响应主服务器，但可能从服务器请求 `A2S_GOLDSRC_INFO`

## 主服务器和游戏服务器

### 服务器到主服务器

#### `S2M_HEARTBEAT`

用于在主服务器上更新游戏服务器信息。

* 请求：`q\xff<heartbeat challenge>`
  - `heartbeat challenge` 是随机 32 位值，用于防止伪造的源 IP 地址。
* 响应：`M2S_CHALLENGE`

#### `S2M_SHUTDOWN`

用于通知主服务器服务器关闭，但出于安全原因必须被任何主服务器实现忽略。

* 请求：`\x62\x0a`
* 响应：无

#### `S2M_INFO`

游戏服务器对 `M2S_CHALLENGE` 的信息响应。

* 请求：`0\n<info>`
  - `info` 是 Quake 信息字符串，包含传递给主服务器的服务器信息。它包含以下字段：
    - `protocol` 始终为 49
    - `challenge` 是主服务器挑战值
    - `players` 是总玩家数，不含机器人
    - `max` 是最大玩家限制
    - `bots` 是总机器人数量
    - `gamedir` 设置为游戏目录
    - `map` 是服务器当前关卡
    - `type` 专用服务器设为 `d`，监听服务器设为 `l`
    - `password` 服务器有密码保护时设为 `1`，否则为 `0`
    - `os` 始终为 `w`
    - `secure` 始终为 `0`
    - `lan` 始终为 `0`
    - `version` 引擎版本
    - `region` 始终为 `255`
    - `product` 与 `gamedir` 相同
    - `nat` 服务器在 NAT 后面时设为 `1`
* 响应：无

### 主服务器到服务器

#### `M2S_CHALLENGE`

主服务器对游戏服务器心跳消息的响应。

* 请求：`s<master challenge><heartbeat challenge>`
  - `master challenge` 包含 32 位值，用于服务器响应以防止伪造的源 IP 地址。
  - `heartbeat challenge` 包含 32 位值，用于心跳请求以防止伪造的源 IP 地址。
* 响应：`S2M_INFO`。

#### `M2S_NAT_CONNECT`

主服务器的包含客户端 IP 地址和端口的消息，用于 NAT 穿透。

* 请求：`c <IP:Port>`
* 响应：`S2C_INFO` 发送到指定的客户端地址。

## 客户端和游戏服务器

### 客户端到服务器

#### `C2S_BANDWIDTHTEST`

用于确定网络 MTU。此消息是可选的，服务器可以选择不实现它或响应挑战。

* 请求，ASCII 格式：`bandwidth <version> <max_size>`
  - `version` 必须是 49，作为文本。
  - `max_size` 是请求的最大数据包大小。

* 可能的响应：
  - `S2C_BANDWIDTHTEST`
  - `S2C_CHALLENGE`
  - `A2A_PRINT` 后跟 `S2C_REJECT`
  - `S2C_ERRORMSG`（作为 FWGS 扩展）后跟 `A2A_PRINT` 和 `S2C_REJECT`。

#### `C2S_GETCHALLENGE`

用于验证客户端地址以防止伪造的源 IP 地址。

* 头部：`\xff\xff\xff\xff`
* 请求，ASCII 格式：`getchallenge steam`
  - `steam` 参数是可选的，服务器可以忽略它，仅为兼容类似的 GoldSrc 48 消息而保留。

* 可能的响应：
  - `S2C_CHALLENGE`

#### `C2S_CONNECT`

用于与服务器建立连接。

* 头部：`\xff\xff\xff\xff`
* 请求，ASCII 格式：`connect <version> <challenge> "<protinfo>" "<userinfo>"`
  - `version` 必须是 49，作为文本。
  - `challenge` 必须是挑战值，作为文本。
  - `protinfo` 是 Quake 信息字符串，包含协议扩展和其他连接信息。
    - `uuid` 是此客户端的唯一 ID（FWGS 扩展），使用 MD5 哈希。
    - `qport` 是从 1 到 65535 的随机整数值，对此引擎运行唯一。
    - `ext` 是与请求的协议扩展进行 OR 运算的整数值。目前唯一扩展是 `NET_EXT_SPLITSIZE`，值为 `1`，告诉服务器根据 `userinfo` 中的 `cl_dlmax` 值分割消息。
  - `userinfo` 包含初始用户信息，编码为 Quake 信息字符串。
* 可能的响应：
  - `A2A_PRINT` 后跟 `S2C_REJECT`
  - `S2C_ERRORMSG`（作为 FWGS 扩展）后跟 `A2A_PRINT` 和 `S2C_REJECT`。
  - `S2C_CONNECTION`

### 服务器到客户端

#### `S2C_BANDWIDTHTEST`

* 请求：`testpacket<crc><blob>`
  - `crc` 是 `blob` 的 32 位 CRC
  - `blob` 是随机数据
* 此消息没有必需的响应

总消息大小不超过请求的最大大小。

#### `S2C_CHALLENGE`

* 请求，ASCII 格式：`challenge <value>`
  - `value` 是客户端必须在其响应中包含的挑战值
* 响应：`C2S_CONNECT`

#### `S2C_CONNECTION`

* 请求，ASCII 格式：`client_connect <protinfo>`
  - `protinfo` 是可选的 Quake 信息字符串，包含以下可选字段：
     - `ext` 是与允许的协议扩展进行 OR 运算的整数值。位字段与 `C2S_CONNECT` 中 `ext` 字段请求的匹配
     - `cheats` 服务器允许作弊时设为 1，否则为 0
* 响应：客户端没有带外响应，但客户端将继续构建网络通道并将客户端-服务器交互切换到它。

#### `S2C_ERRORMSG`

向客户端显示错误消息。不意味着连接拒绝，仅用于 UI。

* 请求，ASCII 格式：`errormsg <message>`
  - `message` 包含错误消息
* 响应：无

#### `S2C_REJECT`

客户端在连接中被拒绝。

* 请求，ASCII 格式：`disconnect`
* 响应：客户端可以应对、沮丧或在心理上告诉服务器滚蛋。
