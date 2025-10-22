{ inputs, ... }:
let
  lib = import ../lib { inherit inputs; };
in
{
  flake.lib = lib;
  flake.modules = import ../modules/hm;
}
