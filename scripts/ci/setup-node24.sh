#!/usr/bin/env bash
set -euo pipefail

NODE_VERSION="${NODE_VERSION:-24.19.0}"
PNPM_VERSION="${PNPM_VERSION:-11.20.0}"
ARCHIVE="node-v${NODE_VERSION}-linux-x64.tar.xz"
DOWNLOAD_URL="https://nodejs.org/dist/v${NODE_VERSION}/${ARCHIVE}"
INSTALL_ROOT="${GITEE_GO_NODE_DIR:-${TMPDIR:-/tmp}/pi-fabric-node-v${NODE_VERSION}}"
TMP_ARCHIVE="${TMPDIR:-/tmp}/${ARCHIVE}"

if [ ! -x "${INSTALL_ROOT}/bin/node" ] || [ "$("${INSTALL_ROOT}/bin/node" -v 2>/dev/null || true)" != "v${NODE_VERSION}" ]; then
  rm -rf "${INSTALL_ROOT}"
  mkdir -p "${INSTALL_ROOT}"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "${DOWNLOAD_URL}" -o "${TMP_ARCHIVE}"
  else
    wget -qO "${TMP_ARCHIVE}" "${DOWNLOAD_URL}"
  fi
  tar -xJf "${TMP_ARCHIVE}" -C "${INSTALL_ROOT}" --strip-components=1
fi

export PATH="${INSTALL_ROOT}/bin:${PATH}"
corepack enable
corepack prepare "pnpm@${PNPM_VERSION}" --activate

node -v
pnpm -v
