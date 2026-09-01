# pi-fabric-plus

`pi-fabric-plus` 是包含式增强包：先加载 upstream `pi-fabric`，再加载本包增强。目标：依赖 upstream，不改 upstream 源码，后续同步 `https://github.com/monotykamary/pi-fabric` 时不和本地增强冲突。

## 加载方式

`package.json` 的 `pi` 清单会加载：

1. `./node_modules/pi-fabric/dist/index.js` —— 基础 `pi-fabric`
2. `./extensions/index.js` —— plus 增强
3. `./node_modules/pi-fabric/skills` —— 基础 Fabric skills

所以用户只装 `pi-fabric-plus`，不用单独装 `pi-fabric`。

## 原则

- 不改 `pi-fabric` 源码。
- 通过 dependency 包含基础 `pi-fabric`。
- 只用 Pi package extension 和 `pi-fabric` 已公开事件协议注册增强。
- 能用 `FABRIC_COMPONENT_REGISTER_EVENT` / `FABRIC_COMPONENT_DISCOVER_EVENT` 做的增强，放 component。
- 不能外部注入的深层能力（runtime bootstrap、内建 settings tree、nested `pi.bash` 内核选项）不硬改；等 upstream 暴露稳定 seam 后再接。

## 安装

```sh
pi install git:https://github.com/kuacode/pi-fabric-plus
```

临时启用：

```sh
pi -e git:https://github.com/kuacode/pi-fabric-plus
```

## 当前能力

- 自动加载基础 `pi-fabric`。
- 注册 `kuacode-role-guidance` component。
- 通过 Fabric component guidance 追加 role-routing 使用建议。
- 提供 `/fabric-plus` 命令查看状态。

在项目 `fabric.json` 启用 guidance：

```json
{
  "components": [
    { "id": "kuacode-role-guidance", "component": "kuacode-role-guidance" }
  ]
}
```
