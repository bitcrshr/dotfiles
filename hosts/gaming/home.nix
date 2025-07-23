{ pkgs, lib, config, inputs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.twilight
    inputs.hyprshell.homeModules.hyprshell
  ];


  programs = {
    zsh.shellAliases = {
      conedit = "tmux new -s dotfiles -c /home/chandler/dotfiles -A";
      update = "sudo -i nixos-rebuild switch --flake /home/chandler/dotfiles#gaming";
    };

    zen-browser.enable = true;

    kitty.enable = true;

  };

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.packages = with pkgs; [
    discord
  ];
}
