{ ... }:
{
  flake.homeModules = {
    default = {
      imports = [
        ../core/helix.nix
        ../core/zsh.nix
        ../core/tmux.nix
        ../core/progs.nix
      ];
    };

    helix = import ../core/helix.nix;
    zsh = import ../core/zsh.nix;
    tmux = import ../core/tmux.nix;
    progs = import ../core/progs.nix;
  };
}
