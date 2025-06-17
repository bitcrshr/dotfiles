{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
  ];

  # Using determinate, which means nix-darwin should not
  # manage the nix install
  nix.enable = false;

  homebrew = {
    enable = true;

    taps = [ ];
    brews = [ ];
    casks = [ "rectangle" "ghostty" "spotify" ];
  };


  users.users.chandler = {
    home = "/Users/chandler";
    packages = with pkgs; [
      stats
      raycast
    ];
  };

  system = {
    primaryUser = "chandler";
    stateVersion = 6;
  };

  # The platform the configuration will be used on.
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
  };

  services = {
    tailscale = {
      enable = true;
    };
  };

  programs = {
    _1password-gui.enable = true;
    zsh.enable = true;
  };
}
