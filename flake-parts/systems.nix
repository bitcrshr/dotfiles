{ inputs, ... }:
let
  lib = import ../lib { inherit inputs; };
in
{
  flake = {
    darwinConfigurations = {
      macbook = lib.mkDarwinSystem {
        system = "aarch64-darwin";
        modulePath = ../hosts/macbook;
      };
    };

    homeConfigurations = {
      linux-generic = lib.mkHomeManager {
        system = "x86_64-linux";
        hostname = "generic-linux";
      };
    };
  };
}
