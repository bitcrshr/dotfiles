{ pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    stats
    raycast
    ripgrep
  ];

  # Using determinate, which means nix-darwin should not
  # manage the nix install
  nix.enable = false;

  homebrew =
    {
      enable = true;

      taps = [ ];
      brews = [ ];
      casks = [ "rectangle" "ghostty" ];
    };

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  users.users.chandler.home = "/Users/chandler";

  system.primaryUser = "chandler";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = {
    allowUnfree = true;
  };

  services.tailscale = {
    enable = true;
  };

  programs = {
    _1password-gui.enable = true;
    _1password.enable = true;
  };

}
