{ pkgs, lib, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
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
      kdePackages.dolphin
      hyprpaper
    ];

    home.file."hyprpaper-config" = {
      enable = true;
      text = ''
        preload = ${./wallpaper.jpg}
        wallpaper = , ${./wallpaper.jpg}
      '';
      target = ".config/hypr/hyprpaper.conf";
      onChange = ''
        hyprpaper
      '';
    };

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
      hyprshell = {
        enable = true;
        systemd.args = "-v";
        settings = {
          windows = {
            overview = {
              key = "space";
              modifier = "alt";
              launcher = {
                max_items = 6;
                launch_modifier = "ctrl";
                default_terminal = "ghostty";
              };
            };
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

        binds = {
          drag_threshold = 10;
        };

        "$mainMod" = "ALT";
        "$terminal" = "ghostty";
        "$fileManager" = "dolphin";
        "$browser" = "zen";

        bind = [
          "$mainMod, Q, killactive,"
          "$mainMod SHIFT, Q, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod SHIFT, F, toggleFloating,"

          "$mainMod, H, movefocus, l"
          "$mainMod, L, movefocus, r"
          "$mainMod, K, movefocus, u"
          "$mainMod, J, movefocus, d"

          "$mainMod SHIFT, H, movewindoworgroup, l"
          "$mainMod SHIFT, L, movewindoworgroup, r"
          "$mainMod SHIFT, K, movewindoworgroup, u"
          "$mainMod SHIFT, J, movewindoworgroup, d"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"

          "$mainMod, RETURN, fullscreen, 1"

          "$mainMod, G, togglegroup"
          "$mainMod, BRACKETLEFT, changegroupactive, b"
          "$mainMod, BRACKETRIGHT, changegroupactive, f"

          "$mainMod, R, splitratio, exact 1"

          # Headset Volume Control
          ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +1%"
          ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -1%"
        ];

        binde = [
          "$mainMod, MINUS, resizeactive, -15 0"
          "$mainMod, EQUAL, resizeactive, 15 0"
          "$mainMod SHIFT, MINUS, resizeactive, 0 -15"
          "$mainMod SHIFT, EQUAL, resizeactive, 0 15"
        ];

        bindm = [
          "$mainMod, mouse:272, resizewindow 2"
          "$mainMod SHIFT, mouse:272, movewindow"
        ];

        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          "content game,class:^steam_app_1422450$"
          "workspace 1,class:^steam_app_1422450$"
        ];

      };

      plugins = [
      ];
    };
  };
}
