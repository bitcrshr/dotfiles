{ pkgs, lib, ... }: {
  hyprland = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "hyprland";
    rev = "v1.3";
    sha256 = lib.fakeHash;
  };
}
