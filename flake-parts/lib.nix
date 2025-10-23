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

        modules =
          let
            pkgs = import nixpkgs { inherit system; };
          in
          [
            # shared nixos config
            {
              networking.hostName = hostname;

              nix.settings = {
                experimental-features = [
                  "nix-command"
                  "flakes"
                ];
              };

              environment.systemPackages = with pkgs; [
                ghostty
              ];

              programs.zsh = {
                enable = true;
                ohMyZsh = {
                  enable = true;
                  plugins = [ "git" ];
                  theme = "robbyrussel";
                };
              };

              users.users.${user}.shell = pkgs.zsh;
            }

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
