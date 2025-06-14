{
  lib,
  config,
  ...
}: {
  imports = [
    ./helix
    ./langs
    ./tmux.nix
    ./zsh.nix
    ./git.nix
  ];
}
