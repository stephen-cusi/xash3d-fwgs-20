🌐 [English](http-server-list.md) | 🇨🇳 [中文](http-server-list.zh-CN.md)

# 静态 HTTP 服务器列表

替代 [02-connectionless.md](02-connectionless.md) 中描述的 UDP `S2M_SCAN_REQUEST` / `M2A_SERVERSLIST` 交换。只读 HTTP，无 NAT 穿透，请求中无过滤或分页。

## URL

`xashcomm.lst` 为每个源携带一个基础 URL：

```
masterstatic http://master.example.org/server-list
```

引擎追加 `/v1/servers/<gamedir>` 并 GET 结果。对于 `gamedir = valve`：

```
GET http://master.example.org/server-list/v1/servers/valve
```

基础 URL 的尾部斜杠会被去除。允许多个 `masterstatic` 行；结果会被合并。

请求是裸的：无请求体、无认证、无 cookie、无压缩编码。仅设置标准 `User-Agent`。不使用 `POST` / `PUT` / `DELETE`；服务器通过带外方式注册。

## 响应

UTF-8 文本，逐行解析。每行使用 `COM_ParseFileSafe` 进行分词（空白分隔，`//` 和 `#` 开始行注释，`"..."` 引用一个标记）。空行和仅注释行被忽略。每行一个指令：

* `ip <address>` — Xash3D 服务器（协议 49）。
* `gs <address>` — GoldSrc 服务器（协议 48）。

`<address>` 由 `NET_StringToAdr` 解析（`1.2.3.4:27015`、`[2001:db8::1]:27015`、主机名）。端口默认为 `27015`。以未知指令开头的行完全跳过，因此可以添加任意数量操作数的新关键字而不会破坏旧客户端。

不检查 `Content-Type`，期望 `text/plain; charset=utf-8`。

### 示例

```
# diffusion 服务器
ip 192.0.2.10:27015
ip [2001:db8::1]:27015
gs 198.51.100.5:27015
```

零记录的文件是有效的，表示空列表。

### 版本控制

`/v1/` 段在此修订版中是固定的。未来的协议修订版将添加同级 `/v2/...` 资源而不破坏旧客户端。

## 客户端行为

响应中的每个 `ip` / `gs` 记录都会触发对列出地址的探测，与通过 UDP 主服务器发现的服务器相同。DNS 错误、非 200 响应和格式错误的响应体会报告到控制台。

## 服务器行为

任何静态 HTTP 服务器都可以工作。典型的设置是定期任务，探测一组已知地址并写入 `v1/servers/<gamedir>`。
