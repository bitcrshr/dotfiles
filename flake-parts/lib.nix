{ inputs, self, ... }:
{
  flake.lib = {
    mkNixOsConfiguration =
      { hostname
      , system ? "x86_64-linux"
      , nixpkgs ? inputs.nixpkgs
      , home-manager ? inputs.home-manager
      , modules ? [ ]
      , user ? "chandler"
      ,
      }: nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          { networking.hostName = hostname; } # shared nixos config

          home-manager.nixosModules.home-manager

          inputs.disko.nixosModules.disko

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users.${user} = {
              imports = [
                self.homeModules.default
              ];

              home.stateVersion = "25.05";
            };
          }
        ] ++ modules;
      };
  };
}
