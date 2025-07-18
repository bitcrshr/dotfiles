{ inputs, ... }:
let
  lib = import ../lib { inherit inputs; };
in
{
  flake = {
    darwinConfigurations = {
      macbook = lib.mkMacOSConfig {
        modules = [ ../hosts/macbook ];
      };
    };

    nixosConfigurations = {
      gaming = lib.mkNixOSConfig {
        system = "x86_64-linux";
        modules = [
          inputs.nixos-facter-modules.nixosModules.facter
          inputs.disko.nixosModules.disko
          ../hosts/gaming
        ];
      };
    };
  };
}
