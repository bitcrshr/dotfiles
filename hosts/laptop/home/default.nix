{ lib
, config
, pkgs
, ...
}: {
  imports = [
    ../../../modules
    ./zsh.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "chandler";
  };


  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";

  programs.git.userName = "Chandler Davis";
  programs.git.userEmail = "chandler.davis99@icloud.com";
}
