{ inputs, ... }: {
  flake.lib = (import ../lib/machine.nix { inherit inputs; });
}
