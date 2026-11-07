# dotfiles

Small chezmoi setup for Helix and Rex on macOS and Linux.

## Install

Install [chezmoi](https://www.chezmoi.io/install/), [just](https://just.systems/),
Helix, and Rex first. The `rex` command must be on PATH when chezmoi renders the
watcher service. Start the local Rex server before running setup.

```sh
chezmoi init bitcrshr/dotfiles
chezmoi cd
just diff
just setup
```

On a remote Rex server, install and apply this repo **on that server**. Rex reads
its server-side config; connecting from a configured Mac doesn't copy it over.
Linux watcher setup uses a systemd user service. To keep user services running
while logged out, enable lingering for that account (`loginctl enable-linger`).
Rex server installation and remote-access configuration are separate.

This repo manages only Helix/Rex config and the Rex history watcher. It doesn't
install applications, language servers, themes outside Helix, or Rex app settings.
It assumes the default `~/.config` location (`XDG_CONFIG_HOME` unset).

## Daily use

```sh
chezmoi edit ~/.config/rex/init.lua
# Or edit dot_config/rex/init.lua directly in this repository.
just diff
just apply
# After changing the watcher script or its service template:
just watcher
git diff
git add .
git commit -m "Update config"
git push
```

If you edit a live config directly, run `chezmoi add PATH` to bring that change
back into the repo before applying. Git pull plus `just setup` updates another
machine. Review `just diff` first.

## Helix

Catppuccin Frappe, soft wrapping, indent guides, inlay hints, and terminal
clipboard integration. `=` / `-` switch buffers. TypeScript's language server
is launched through Bun; install Bun and make `typescript-language-server`
available to it if you use that override.

The local development `runtime` symlink is intentionally excluded. Use the
runtime bundled with your Helix installation, or configure a development checkout
separately.

## Rex

Press **Ctrl+Space**, release, then the command key. Rex tabs correspond to tmux
windows. Native Mac shortcuts remain available.

| Key after prefix | Action |
| --- | --- |
| `c`, `n`, `p` | New, next, previous tab |
| `0`–`9` | First through tenth tab (tmux numbering) |
| `%`, `"` | Split right, down (US keyboard layout) |
| Arrows | Focus pane |
| `;` | Toggle last focused pane in this tab |
| `o` | Next pane |
| `z`, `x` | Zoom, close pane (last pane closes its tab) |
| `s`, `w` | Session picker, go-to picker |
| `,`, `$` | Rename tab, session |
| `!` | Move pane to new tab |
| `]` | Paste clipboard |
| `:`, `?` | Command palette |
| Ctrl+Space | Send literal Ctrl+Space |
| Alt+arrow | Resize and enter repeat resize mode |
| Ctrl+arrow | Resize once |

Without the prefix:

- **Ctrl+Shift+H/J/K/L**: focus left/down/up/right.
- **Ctrl+K**: clear screen and scrollback; Rex leaves full-screen programs alone.
- **Alt+I**: show/hide a persistent floating shell per tab, at 70% size. New shells
  inherit the focused process's directory when available and use Rex's default shell.

In repeat resize mode, keep using Alt+arrows; **Escape or Enter** exits. Rex has
no idle timeout for this mode. On macOS, configure Option to send Alt in Rex if
needed. Native vi copy mode isn't implemented here.

The last-pane watcher tracks mouse and keyboard focus. It runs locally against
the server and writes pane IDs to `~/.local/state/rex-pane-history/`; generated
history and logs are not tracked in Git. With no valid history, `;` selects
another visible pane. History is best effort across watcher/server restarts.
