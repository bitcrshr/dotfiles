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
  };
}
