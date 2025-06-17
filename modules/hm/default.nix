{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./helix
  ];

  programs.git = {
    enable = true;

    userName = "Chandler Davis";
  };

  home.packages = with pkgs; [
    fzf
    ripgrep
    btop
  ];
}
