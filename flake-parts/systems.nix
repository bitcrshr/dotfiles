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
          inputs.disko.nixosModules.disko
          ../hosts/gaming
        ];
      };

      k8s-master = lib.mkK3sNode {
        system = "x86_64-linux";
        hostname = "k8s-master";
        server = true;
      };
    };
  };

}
