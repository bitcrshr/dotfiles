{
  description = "bitcrshr's dotfiles and various configs";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker";
    };

    hyprshell = {
      url = "github:H3rmt/hyprshell?ref=601c7eb1a61854d0d70b257447e9ddc044810855";
    };

    nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ withSystem, flake-parts-lib, ... }:
      let
      in
      {
        imports = [
          inputs.home-manager.flakeModules.home-manager

          ./flake-parts/lib.nix
          ./flake-parts/shared-modules.nix
          ./flake-parts/machines.nix
        ];
        systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
        perSystem = { config, self', inputs', pkgs, system, ... }: {
          # Per-system attributes can be defined here. The self' and inputs'
          # module parameters provide easy access to attributes of the same
          # system.

        };
        flake = {
          homeModules = {
            default = import ./core;
          };
        };
      });
}
