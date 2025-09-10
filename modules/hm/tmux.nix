{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    escapeTime = 10;
    sensibleOnTop = true;

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.nord
      tmuxPlugins.tmux-fzf

      {
        plugin = tmuxPlugins.mkTmuxPlugin {
          pluginName = "tmux-floating-terminal";
          version = "unstable-2025-05-27";
          src = pkgs.fetchFromGitHub {
            owner = "lloydbond";
            repo = "tmux-floating-terminal";
            rev = "1d8192ce45fedc820cb7c7e0fc2fbc8095952970";
            sha256 = "sha256-NZh6fbrbAO3TTZLOJJVyEsWWLEr48gFEyHEcXxfk+NY=";
          };

          rtpFilePath = "floating_plugin.tmux";
        };
      }

    ];

    extraConfig =
      let
        tmux-fzf-path = "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf";
      in
      ''
        unbind C-b
        set-option -g prefix "C-Space"
        bind-key "C-Space" send-prefix 

        set -gu default-command
        set -g default-shell "$SHELL"

        set-window-option -g mouse on
        set -g history-limit 30000
        set -g mouse on
        set -g set-clipboard on
        set -g main-pane-height 80
        set -as terminal-features ",xterm-256color:clipboard"

        TMUX_FZF_SWITCH_CURRENT=1
        TMUX_FZF_ORDER="pane|session|window|command|keybinding|clipboard|process"
        TMUX_FZF_LAUNCH_KEY="f"

        bind-key -T prefix p run-shell -b "${tmux-fzf-path}/scripts/pane.sh switch"
        bind-key -T prefix s run-shell -b "${tmux-fzf-path}/scripts/session.sh switch"

        bind-key -T prefix I source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
    
        bind -n C-k clear-history

        # Override the binding to use literal session name
        bind-key M-i if-shell -F '#{==:#S,floating}' {
          detach-client
        } {
          set -gF '@last_session_name' '#S'
          popup -d '#{pane_current_path}' -xC -yC -w70% -h70% -E 'tmux -f ~/.config/tmux/tmux.conf new -A -s floating'
        }
      '';
  };
}
