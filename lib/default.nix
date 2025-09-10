{ inputs }:
let
  inherit (inputs) nixpkgs home-manager nix-darwin;
in
{
  # Function to build a NixOS system
  mkNixOSSystem =
    { system, hostname, specialArgs ? { }, self ? inputs.self, modules ? [ ] }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = specialArgs // { inherit inputs; };
      modules = [
        # Host-specific configuration
        (self + "/hosts/${hostname}/configuration.nix")

        # Home Manager module for NixOS
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # User-specific home-manager config
          home-manager.extraSpecialArgs = specialArgs // { inherit inputs; };
          home-manager.users.chandler = import (self + "/hosts/${hostname}/home.nix");
        }
      ] ++ modules;
    };

  # Function to build a nix-darwin system
  mkDarwinSystem =
    { system, modulePath, specialArgs ? { } }:
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = specialArgs // { inherit inputs; };
      modules = [
        modulePath

        # Home Manager module for nix-darwin
        home-manager.darwinModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          # User-specific home-manager config
          home-manager.extraSpecialArgs = specialArgs // { inherit inputs; };
        }
      ];
    };

  mkHomeManager =
    { system, hostname, modules }:
    home-manager.lib.homeManagerConfiguration {
      inherit modules;

      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs; };
    };
}
