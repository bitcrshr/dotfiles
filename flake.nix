{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";

    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker/v0.13.26";
    };

    nix-darwin-linking = {
      url = "github:dwt/nix-darwin/application-linking-done-right";
      inputs.nixpkgs.follows = "nixpkgs";
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
