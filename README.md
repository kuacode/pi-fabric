# pi-fabric-plus

`pi-fabric-plus` 是独立 Pi package。目标：增强 `pi-fabric`，但不修改 upstream `https://github.com/monotykamary/pi-fabric` 源码，后续拉取 upstream 基本不和本地增强冲突。

## 原则

- 不改 `pi-fabric` 源码。
- 只用 Pi package extension 和 `pi-fabric` 已公开事件协议注册能力。
- 能用 `FABRIC_COMPONENT_REGISTER_EVENT` / `FABRIC_COMPONENT_DISCOVER_EVENT` 做的增强，放 component。
- 不能外部注入的深层能力（runtime bootstrap、内建 settings tree、nested `pi.bash` 内核选项）不硬改；等 upstream 暴露稳定 seam 后再接。

## 安装

```sh
pi install /absolute/path/to/pi-fabric-plus
```

临时启用：

```sh
pi -e /absolute/path/to/pi-fabric-plus
```

## 当前能力

- 注册 `kuacode-role-guidance` component。
- 通过 Fabric component guidance 追加 role-routing 使用建议。
- 提供 `/fabric-plus` 命令查看状态。

在项目 `fabric.json` 启用：

```json
{
  "components": [
    { "id": "kuacode-role-guidance", "component": "kuacode-role-guidance" }
  ]
}
```
