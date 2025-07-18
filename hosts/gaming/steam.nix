{ pkgs, ... }: {
  programs = {
    steam = {
      enable = true;

      gamescopeSession.enable = true;
    };

    gamemode.enable = true;
  };

  hardware.logitech.wireless =
    {
      enable = true;
      enableGraphical = true;
    };

  environment.systemPackages = with pkgs;
    [
      mangohud
      protonup-qt
      lutris
      bottles
      solaar
      logitech-udev-rules
      spotify
    ];
}
