{ pkgs, inputs, ... }:

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

    programs = {
      kitty.enable = true;

      walker = {
        enable = true;
        runAsService = true;

        config = {
          search.placeholder = "hey";
        };
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

        "$mod" = "SUPER";

        "exec-once" = [
          "walker --gapplication-service"
        ];
      };

      plugins = with pkgs.hyprlandPlugins; [

      ];
    };
  };
}
