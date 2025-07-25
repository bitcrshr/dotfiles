{ config, pkgs, inputs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = false;
  };


  services.xserver = {
    enable = true;
    videoDrivers = [];
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  services.kmscon.enable = true;

  services.greetd =
    let
      hyprland-session = "${config.programs.hyprland.package}/share/wayland-sessions";
    in
    {
      enable = true;
      settings = {
        default_session = {
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
              --debug \
              --time \
              --remember \
              --remember-session \
              --cmd Hyprland
          '';
        };
      };
    };

  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  hardware.logitech = {
    wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
