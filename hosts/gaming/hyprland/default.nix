{ pkgs, lib, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://walker.cachix.org"
      "https://walker-git.cachix.org"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
      "https://walker.cachix.org"
      "https://walker-git.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
    ];
  };

  home-manager.users.chandler = {
    imports = [
      inputs.walker.homeManagerModules.default
      ./waybar
    ];

    home.packages = with pkgs; [
      noto-fonts
      nerd-fonts.jetbrains-mono
      pipewire
      wireplumber
      hyprpolkitagent
      libsForQt5.dolphin
      hyprpaper
    ];

    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    gtk = {
      enable = true;
    };

    programs = {
      walker = {
        enable = true;
        runAsService = true;

        config = {
          close_when_open = true;

          keys = {
            activation_modifiers.alternate = "ralt";
            trigger_labels = "ralt";
          };
        };
      };

    };

    services = {
      dunst = {
        enable = true;

        settings = { };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd.enable = false;
      settings = {
        env = [
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_DESKTOP,Hyprland"
        ];


        "exec-once" = [
          "uwsm finalize"
          "walker --gapplication-service"
          "hyprctl setcursor Bibata-Modern-Ice 24"
        ];

        input = {
          kb_layout = "us";
          kb_model = "pc104";
          kb_options = "terminate:ctrl_alt_bksp";
        };

        general = {
          layout = "dwindle";
        };

        monitor = [
          "DP-1, 1920x1080@144, 0x0, 1"
          "DP-2, 1920x1080@60, 1920x-600, 1, transform, 1"
        ];

        "$mainMod" = "ALT";
        "$terminal" = "ghostty";
        "$fileManager" = "dolphin";
        "$menu" = "walker";
        "$browser" = "zen";

        bind = [
          "$mainMod, Q, killactive,"
          "$mainMod SHIFT, Q, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod SHIFT, F, toggleFloating,"
          "$mainMod, SPACE, exec, $menu"

          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          "$mainMod SHIFT, H, movewindow, l"
          "$mainMod SHIFT, L, movewindow, r"
          "$mainMod SHIFT, K, movewindow, u"
          "$mainMod SHIFT, J, movewindow, d"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"

          "$mainMod, RETURN, fullscreen, 1"

        ];

        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];

      };

      plugins = with pkgs.hyprlandPlugins; [

      ];
    };
  };
}
