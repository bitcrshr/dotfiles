{ pkgs, config, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./tmux.nix
    ./helix
  ];

  programs = {
    git = {
      enable = true;
      userName = "Chandler Davis";
      userEmail = "chandler.davis99@icloud.com";
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };


    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };

  home.packages = with pkgs;
    [
      fzf
      ranger
      ripgrep
      btop
      delta
      tailscale
      age
    ];
}
