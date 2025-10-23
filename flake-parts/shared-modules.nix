{ ... }:
{
  flake.homeModules = {
    default = import ../core;

    helix = import ../core/helix.nix;
    zsh = import ../core/zsh.nix;
    tmux = import ../core/tmux.nix;
    progs = import ../core/progs.nix;
  };
}
