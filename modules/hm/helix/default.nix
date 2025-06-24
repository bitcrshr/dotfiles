{ pkgs, ... }:
{
  imports = [
    ./settings.nix
    ./languages.nix
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
  };
}
