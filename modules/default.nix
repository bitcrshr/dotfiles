{
  lib,
  ...
}: {
  imports = [
    ./helix
    ./langs
    ./tmux.nix
    ./zsh.nix
  ];

  systemd.user.startServices = "sd-switch";
}
