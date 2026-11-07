# Working in this repo

Keep this a small chezmoi setup for Helix and Rex. Prefer documented `just`
recipes over standalone setup scripts. Preserve existing keybindings unless the
requested change calls for altering them.

## Source and deployment

- Edit the files in this repo, not the live files under `~/.config`.
  `dot_config/` maps to `.config/`; `private_` controls permissions and `.tmpl`
  files are rendered by chezmoi.
- Keep repository-only files in `.chezmoiignore`, or chezmoi will install them
  into the home directory. Ignore patterns use destination paths, without source
  attributes such as `private_`.
- Keep generated pane history, logs, credentials, and Helix's development runtime
  symlink out of Git. This repo is public.
- Rex reads config on the server machine. Applying on the Mac does not configure
  a remote Linux server. The current setup assumes `XDG_CONFIG_HOME` is unset.
- Watcher templates resolve `rex` from PATH at apply time. Reapply after its path
  changes. macOS uses launchd; Linux uses a systemd user service.

## Rex details worth preserving

- Use the installed client's action schemas (`rex -C CLIENT actions --json`) and
  `rex api describe METHOD` before assuming an action or argument exists. Rex is
  in beta, and config validation alone does not verify runtime behavior.
- Rex tab indices start at 1; our leader `0`–`9` bindings deliberately add 1.
- Last-pane switching depends on `pane-history.lua` plus its watcher service.
  Preserve the invoking-pane context, missing/stale-history fallback, and
  immediate history update: relying only on asynchronous watcher events caused
  a bug where switching needed a mouse click first.
- Repeat resizing uses a mode with Escape/Enter to exit. There is no configured
  idle timeout. The floating shell is persistent per tab and uses Rex's default
  shell; don't hardcode a Mac-only shell path.

## Verify and apply

Run `just check` and review `just diff`, then use `just apply` for config changes.
Run `just watcher` after changing the watcher script or service template;
`just setup` does both. For documentation-only changes, check the Git diff and
chezmoi's managed-file list without restarting Rex.

For behavior changes, test in a temporary Rex session and remove it afterward;
don't close or modify the user's working sessions. Last-pane checks should cover
first use without history, repeated toggles, and stale history. Report which
platforms were actually exercised; Linux service setup has not yet been tested
on Linux.
