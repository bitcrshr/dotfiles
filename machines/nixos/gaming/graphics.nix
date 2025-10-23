{ config, pkgs, inputs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  environment.systemPackages = with pkgs; [
    tuigreet
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
            ${pkgs.tuigreet}/bin/tuigreet \
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

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
