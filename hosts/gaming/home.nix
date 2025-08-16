{ pkgs, lib, config, inputs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.twilight-official
    inputs.hyprshell.homeModules.hyprshell
  ];


  programs = {
    zsh = {
      shellAliases = {
        conedit = "tmux new -s dotfiles -c /home/chandler/dotfiles -A";
        update = "sudo -i nixos-rebuild switch --flake /home/chandler/dotfiles#gaming";
      };

      initContent = lib.mkOrder 1000 ''
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
  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    discord
    obsidian
    blender
  ];
}
