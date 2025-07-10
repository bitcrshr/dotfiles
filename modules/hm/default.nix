{ pkgs, config, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./helix
  ];

  programs = {
    git.enable = true;

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs;
    [
      fzf
      ripgrep
      btop
      delta
      tailscale
    ];
}
