#!/usr/bin/env bash
set -euo pipefail

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)"
cd "$ROOT"

bash ./scripts/ci/setup-node24.sh
pnpm install --frozen-lockfile
pnpm run check
pnpm run build
