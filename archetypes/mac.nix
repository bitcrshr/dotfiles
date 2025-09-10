{ pkgs, lib, config, ... }:

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

    onActivation = {
      cleanup = "zap";
    };

    taps = [ ];
    brews = [ ];
    casks = [
      "rectangle"
      "ghostty"
      "spotify"
      "zen"
      "appcleaner"
      "obsidian"
    ];
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


  home-manager.users.chandler = {
    imports = [
      ../modules/hm
    ];

    home = {
      username = "chandler";
      stateVersion = "25.05";
    };

    systemd.user.startServices = "sd-switch";

    programs.zsh = {
      # macos already comes with zsh, so don't let home manager install another binary
      package = pkgs.emptyDirectory;

      initContent = ''
        export PATH="$PATH:/run/current-system/sw/bin"
      '';
    };
  };

  programs = {
    zsh.enable = false; # let home-manager manage the zsh install
  };
}
