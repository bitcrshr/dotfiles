{ pkgs, lib, ... }:
{
  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "Chandler Davis";
        email = lib.mkDefault "chandler.davis99@icloud.com";
      };
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

  home.packages = with pkgs; [
    fzf
    ranger
    ripgrep
    btop
    delta
    tailscale
    nix-search
  ];
}
