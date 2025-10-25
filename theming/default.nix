{ pkgs, lib, ... }: {
  catppuccin = import ./catppuccin.nix { inherit pkgs lib; };
}
