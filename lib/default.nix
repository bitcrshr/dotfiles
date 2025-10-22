{ inputs }:
let
  inherit (inputs) self nixpkgs home-manager nix-darwin;
in
{
  mkMacOSConfig = { modules ? [ ], specialArgs ? { }, system ? "aarch64-darwin" }:
    nix-darwin.lib.darwinSystem {
      inherit system;

      specialArgs = specialArgs // { inherit inputs; };

      modules = [
        (self + "/archetypes/mac.nix")

        home-manager.darwinModules.home-manager

        {
          home-manager.useGlobalPkgs = true;

          home-manager.extraSpecialArgs = specialArgs // { inherit inputs system; };
        }
      ] ++ modules;
    };

  mkNixOSConfig =
    { system
    , specialArgs ? { }
    , modules ? [ ]
    ,
    }:
    nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = specialArgs // {
        inherit inputs;
      };

      modules = [
        (self + "/archetypes/nixos")

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = specialArgs // { inherit inputs system; };
        }
      ] ++ modules;
    };

  # TODO: mkStandaloneHmConfig
}
