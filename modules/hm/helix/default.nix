{ pkgs, inputs, system, ... }:
let
  unstablePkgs = import inputs.nixpkgs-unstable { inherit system; };
in
{
  imports = [
    ./settings.nix
    ./languages.nix
    ./themes.nix
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = unstablePkgs.helix;
  };
}
