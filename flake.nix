{
  description = "bitcrshr's many machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter-modules = {
      url = "github:numtide/nixos-facter-modules";
    };
  };

  outputs = { nixpkgs, home-manager, disko, nixos-facter-modules, ... }:
    let
      mkPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkHomeConfig = { system, username, homeDirectory, modules }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          modules = [
            {
              nixpkgs = {
                config = {
                  allowUnfree = true;
                };
              };
              home.username = username;
              home.homeDirectory = homeDirectory;
              home.stateVersion = "25.05";
              programs.home-manager.enable = true;
            }
          ] ++ modules;
        };
    in
    {
      homeConfigurations = {
        "laptop" = mkHomeConfig {
          system = "aarch64-darwin";
          username = "chandler";
          homeDirectory = "/Users/chandler";
          modules = [
            (import ./hosts/laptop).homeConfiguration
          ];
        };
      };

      # Outputs for other flakes to extend this one are below

      baseModules = import ./modules;
    };
}
