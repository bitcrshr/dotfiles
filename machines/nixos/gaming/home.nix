{ pkgs, lib, config, inputs, system, ... }:
{
  imports = [
    inputs.zen-browser.homeModules.twilight-official
    inputs.hyprshell.homeModules.hyprshell
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };


  programs = {
    zsh = {
      shellAliases = {
        conedit = "tmux new -s dotfiles -c /home/chandler/dotfiles -A";
        update = "sudo -i nixos-rebuild switch --flake /home/chandler/dotfiles#gaming";
      };

      initContent = lib.mkOrder 1000 ''
        export PATH="$PATH:$HOME/.pulumi/bin"
        export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
      '';
    };

    zen-browser.enable = true;

    kitty.enable = true;

    rclone = {
      enable = true;
    };

    irssi = {
      enable = true;
      networks."sociallol" = {
        nick = "chan";
        server = {
          address = "irc.social.lol";
          port = 6697;
        };
      };
    };
    k9s = {
      enable = true;
      settings.k9s = {
        ui.skin = "nord";
        reactive = true;
      };
      skins = {
        nord = ''
          # -----------------------------------------------------------------------------
          # Nord skin
          # -----------------------------------------------------------------------------

          # Styles...
          foreground: &foreground "#DADEE8"
          background: &background "#30343F"
          current_line: &current_line "#383D4A"
          selection: &selection "#D9DEE8"
          comment: &comment "#8891A7"
          cyan: &cyan "#88C0D0"
          green: &green "#A3BE8C"
          orange: &orange "#D08770"
          blue: &blue "#81A1C1"
          magenta: &magenta "#B48EAD"
          red: &red "#BF616A"
          yellow: &yellow "#EBCB8B"

          # Skin...
          k9s:
            # General K9s styles
            body:
              fgColor: *foreground
              bgColor: default
              logoColor: *magenta
            # Command prompt styles
            prompt:
              fgColor: *foreground
              bgColor: *background
              suggestColor: *orange
            # ClusterInfoView styles.
            info:
              fgColor: *blue
              sectionColor: *foreground
            # Dialog styles.
            dialog:
              fgColor: *foreground
              bgColor: default
              buttonFgColor: *foreground
              buttonBgColor: *magenta
              buttonFocusFgColor: *yellow
              buttonFocusBgColor: *blue
              labelFgColor: *orange
              fieldFgColor: *foreground
            frame:
              # Borders styles.
              border:
                fgColor: *selection
                focusColor: *current_line
              menu:
                fgColor: *foreground
                keyColor: *blue
                # Used for favorite namespaces
                numKeyColor: *blue
              # CrumbView attributes for history navigation.
              crumbs:
                fgColor: *foreground
                bgColor: *current_line
                activeColor: *current_line
              # Resource status and update styles
              status:
                newColor: *cyan
                modifyColor: *magenta
                addColor: *green
                errorColor: *red
                highlightColor: *orange
                killColor: *comment
                completedColor: *comment
              # Border title styles.
              title:
                fgColor: *foreground
                bgColor: *current_line
                highlightColor: *orange
                counterColor: *magenta
                filterColor: *blue
            views:
              # Charts skins...
              charts:
                bgColor: default
                defaultDialColors:
                  - *magenta
                  - *red
                defaultChartColors:
                  - *magenta
                  - *red
              # TableView attributes.
              table:
                fgColor: *foreground
                bgColor: default
                # Header row styles.
                header:
                  fgColor: *foreground
                  bgColor: default
                  sorterColor: *cyan
              # Xray view attributes.
              xray:
                fgColor: *foreground
                bgColor: default
                cursorColor: *current_line
                graphicColor: *magenta
                showIcons: false
              # YAML info styles.
              yaml:
                keyColor: *blue
                colonColor: *magenta
                valueColor: *foreground
              # Logs styles.
              logs:
                fgColor: *foreground
                bgColor: default
                indicator:
                  fgColor: *foreground
                  bgColor: *magenta
                  toggleOnColor: *magenta
                  toggleOffColor: *blue
              help:
                fgColor: *foreground
                bgColor: *background
                indicator:
                  fgColor: *red
        '';
      };
    };

  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";


  home.packages = with pkgs; [
    discord
    obsidian
    blender
    terraform
    kubectl
    remmina
    libreoffice
    opam
    ocamlPackages.findlib
    zig
    zls
    ranger
    gimp
  ];
}
