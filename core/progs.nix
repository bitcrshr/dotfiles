{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      userName = "Chandler Davis";
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
  ];
}
