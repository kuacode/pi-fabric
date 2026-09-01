# Gitee Go CI/CD

本仓库提供了 `./.gitee/workflows/main-check-build.yml`，用于在 Gitee 的 `main` 分支 push 后自动执行校验与构建。

## 已落地内容

- 触发条件：`main` 分支 push。
- 执行命令：`pnpm install --frozen-lockfile` → `pnpm run check` → `pnpm run build`。
- 构建产物：上传 `dist/` 作为 `DIST_ARTIFACT`。
- 运行时引导：`scripts/ci/setup-node24.sh` 会在 Gitee Go 的 Node.js 插件环境里下载并激活 Node `24.19.0` 与 `pnpm 11.20.0`。

这样做原因很简单：Gitee Go 官方 Node.js 构建插件文档当前列出的内置版本上限是 `15.12.0`，而本仓库 `package.json` 要求 `node >=24`，所以流水线里先引导本仓库实际需要的 Node 版本。

## 启用方式

1. 打开 Gitee 仓库。
2. 进入 **Gitee Go**。
3. 选择从仓库 YAML 创建/导入流水线。
4. 选择 `./.gitee/workflows/main-check-build.yml`。
5. 保存后，给 `main` 推一次提交验证流水线。

## 关于同步到 `kuacode`

`kuacode` 镜像同步，优先用 Gitee 自带的 **仓库镜像管理（Gitee<->GitHub 双向同步）**，别把 Git 凭据写进流水线脚本。

推荐配置：

1. Gitee 仓库 → **管理** → **仓库镜像管理**。
2. 新增 GitHub 目标仓库：`https://github.com/kuacode/pi-fabric.git`。
3. 按 Gitee 页面要求配置 GitHub token 权限。
4. 开启从 Gitee 到 GitHub 的同步。

这样分工最省事：

- **CI**：`./.gitee/workflows/main-check-build.yml`
- **CD/镜像**：Gitee 原生仓库同步

## 后续可加项

如果你后面确定要“构建成功后才允许同步到 `kuacode`”，再补第二条流水线或改成带人工门禁的发布流。当前先保留最小可维护方案。
