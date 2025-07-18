{ pkgs, lib, config, inputs, ... }: {
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];


  programs = {
    zsh.shellAliases = {
      conedit = "tmux new -s dotfiles -c /home/chandler/dotfiles -A";
      update = "sudo -i nixos-rebuild switch --flake /home/chandler/dotfiles#gaming";
    };

    zen-browser.enable = true;
  };

  home.packages = with pkgs; [
    discord
  ];
}
