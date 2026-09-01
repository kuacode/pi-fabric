# AGENTS.md

## Golden rule: build when done

Always finish a change with a fresh build before handing it back:

```sh
pnpm run build
```

Pi loads and publishes the compiled bundle in `dist/` — not `src/`. Tests run
against `src/`, so green tests alone are not enough: without a build the
change is invisible in the TUI and unpublished. Rebuild so the user can
verify immediately.

## Before committing

```sh
pnpm run check
```

This runs typecheck, build, the full test suite, and dead-code lint. Keep it
green; a build alone is not completion.

## Commits

Use conventional commits (commitlint): `feat(scope): ...`, `fix(scope): ...`,
`chore(release): <version>` for version bumps.

## Merge conflict resolution

When resolving merge conflicts in `src/config.ts`, `src/fabric-runtime-state.ts`,
`src/ui/settings.ts`, or `docs/configuration.md`, **always keep these fabric
bash additions** — they are a local feature, not upstream:

### `src/config.ts`
- `FabricBashConfig` interface (with `shellPath?`, `commandPrefix?`,
  `exposeSessionEnvironment`, `env`)
- `bash: FabricBashConfig` in `FabricConfig`
- `bash` defaults in `DEFAULT_FABRIC_CONFIG`
- `bash` normalization block in `normalizeFabricConfig`

### `src/fabric-runtime-state.ts`
- `import { readFileSync } from "node:fs"`
- `resolvePiShellPath()` function
- `const shellPath = this.#config!.bash.shellPath ?? resolvePiShellPath()` in
  `PiToolsProvider` creation

### `src/ui/settings.ts`
- `"bash"` in `ROOT_ITEM_IDS` (after `"prewalk"`, before `"agents"`)
- `"bash"` in `RELOAD_SECTIONS`
- bash-related `coerceValue` cases
- `case "bash"` in `summaryFor`
- Bash settings submenu (shellPath, commandPrefix, exposeSessionEnvironment)

### `docs/configuration.md`
- Bash configuration section with `FabricBashConfig` fields

Resolve by hand — do not auto-accept either side without checking for these.
Run `pnpm run build` after resolution.
