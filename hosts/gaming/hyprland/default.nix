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

    programs = {
      walker = {
        enable = true;
        runAsService = true;

        config = {
          search.placeholder = "hey";
        };
      };

      waybar =
        let
          repo = pkgs.fetchgit {
            url = "https://github.com/woioeow/hyprland-dotfiles.git";
            sparseCheckout = [
              "hypr_style1/waybar"
            ];
            hash = "sha256-0u4bNmvMG772rhnYVyxodCmJqd+cJcM4V6gd7L+ioII=";
          };

          style =
            builtins.readFile (
              (builtins.toPath (repo)) + "/hypr_style1/waybar/style.css"
            );

          settings = builtins.fromJSON (
            builtins.readFile ./waybar/config.json
          );
        in
        {
          enable = true;

          systemd.enable = true;

          inherit style settings;
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
        ];

        "$mainMod" = "SUPER";

        "exec-once" = [
          "uwsm finalize"
          "walker --gapplication-service"
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

        "$terminal" = "ghostty";
        "$fileManager" = "dolphin";
        "$menu" = "walker";
        "$browser" = "zen";

        bind = [
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, toggleFloating,"
          "$mainMod, R, exec, $menu"
          "$mainMod, B, exec, $browser"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
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
