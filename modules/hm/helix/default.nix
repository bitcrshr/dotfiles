{ pkgs, ... }:
{
  imports = [
    ./settings.nix
    ./languages.nix
    ./themes.nix
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
}
