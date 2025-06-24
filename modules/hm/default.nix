{ pkgs, config, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./helix
  ];

  programs.git = {
    enable = true;

  };

  home.packages = with pkgs;
    [
      fzf
      ripgrep
      btop
      delta
    ];
}
