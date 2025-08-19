{ inputs }:
let
  inherit (inputs) self nixpkgs home-manager nix-darwin;
in
{
  mkMacOSConfig = { modules ? [ ], specialArgs ? { } }:
    nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      specialArgs = specialArgs // { inherit inputs; };

      modules = [
        (self + "/archetypes/mac.nix")

        home-manager.darwinModules.home-manager

        {
          home-manager.useGlobalPkgs = true;

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

  mkK3sNode =
    { system
    , hostname
    , server
    }:
    nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs; };

      modules = [
        {
          knode = {
            enable = true;
            inherit hostname server;
          };
        }

        (self + "/archetypes/nixos")
        (self + "/hosts/k8s_node")
        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = { inherit inputs; };
        }

      ];
    };
}
