{ pkgs, lib, ... }:

let
  # Get all .nix files in this directory except default.nix
  langFiles = builtins.filter
    (name: name != "default.nix" && lib.hasSuffix ".nix" name)
    (builtins.attrNames (builtins.readDir ./.));

  # Import each language file
  langConfigs = map (file: import (./. + "/${file}") { inherit pkgs lib; }) langFiles;
in
{
  # Merge all language configurations
  imports = langConfigs;
}
