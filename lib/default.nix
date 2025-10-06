{ inputs }:
let
  inherit (inputs) self nixpkgs nixpkgs-unstable home-manager home-manager-unstable nix-darwin nix-darwin-linking;
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

  mkHomeManagerConfig = { system, specialArgs ? { }, modules ? [ ] }:
    let
      pkgs = import nixpkgs-unstable { inherit system; };
    in
    home-manager-unstable.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit system inputs; } // specialArgs;

      modules = [
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.stateVersion = "25.05";
        }
      ] ++ modules;
    };
}
