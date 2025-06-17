{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./helix
  ];

  home.packages = with pkgs; [
    fzf
    ripgrep
    btop
  ];
}
