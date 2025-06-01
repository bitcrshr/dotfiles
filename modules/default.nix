{
  lib,
  ...
}: {
  imports = [
    ./helix
    ./langs
    ./tmux.nix
    ./zsh.nix
    ./git.nix
  ];

  systemd.user.startServices = "sd-switch";
}
