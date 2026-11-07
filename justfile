default:
    @just --list

# Validate the Rex config before applying it.
check:
    rex config check "{{justfile_directory()}}/dot_config/rex/init.lua"

# Preview changes to managed files.
diff:
    chezmoi --source "{{justfile_directory()}}" diff

# Install configs and reload the local Rex server.
apply: check
    chezmoi --source "{{justfile_directory()}}" apply
    rex config reload

# Start/restart the last-pane history watcher on this machine.
watcher:
    #!/bin/sh
    set -eu
    case "$(uname -s)" in
      Darwin)
        service="gui/$(id -u)/com.bitcrshr.rex-pane-history"
        if launchctl print "$service" >/dev/null 2>&1; then
          launchctl bootout "$service"
        fi
        launchctl bootstrap "gui/$(id -u)" "$HOME/Library/LaunchAgents/com.bitcrshr.rex-pane-history.plist"
        ;;
      Linux)
        systemctl --user daemon-reload
        systemctl --user enable rex-pane-history.service
        systemctl --user restart rex-pane-history.service
        ;;
      *) echo 'Watcher setup supports macOS and systemd Linux.' >&2; exit 1 ;;
    esac

# Apply everything and start the watcher.
setup: apply watcher
