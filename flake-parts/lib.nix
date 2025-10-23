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
          [
            # shared nixos config
            ({ pkgs, ... }: {
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
                  theme = "robbyrussell";
                };
              };

              users.users.${user}.shell = pkgs.zsh;
            })

            inputs.disko.nixosModules.disko

            home-manager.nixosModules.home-manager

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
