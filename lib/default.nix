{ inputs }:
let
<<<<<<< HEAD
  inherit (inputs) nixpkgs home-manager nix-darwin;
||||||| 35eb7b1
  inherit (inputs) nixpkgs home-manager nix-darwin sops-nix opnix;
=======
  inherit (inputs) self nixpkgs home-manager home-manager-unstable nix-darwin nix-darwin-linking;
>>>>>>> 6857ba2e177d4d352f72f6e9c00c96a09e756e34
in
{
  mkMacOSConfig = { modules ? [ ], specialArgs ? { } }:
    let
      home-manager = home-manager-unstable;
    in
    nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = specialArgs // { inherit inputs; };

      modules = [
        { disabledModules = [ "system/applications.nix" ]; }
        "${nix-darwin-linking}/modules/system/applications.nix"
        (self + "/archetypes/mac.nix")

        home-manager.darwinModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.backupFileExtension = "backup";

          home-manager.extraSpecialArgs = specialArgs // { inherit inputs; };
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

          home-manager.extraSpecialArgs = specialArgs // { inherit inputs; };
        }
      ] ++ modules;
    };

  # TODO: mkStandaloneHmConfig
}
