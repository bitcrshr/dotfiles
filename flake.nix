{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
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
      url = "github:H3rmt/hyprshell?ref=hyprshell-release";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" ];

      imports = [
        ./flake-parts/systems.nix
        ./flake-parts/exports.nix
        ./flake-parts/templates.nix
      ];

      perSystem = { config, pkgs, ... }: {
        devShells = {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [
              nixpkgs-fmt
              nil
            ];
          };
        };
      };
    };
}
