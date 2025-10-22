{ pkgs, config, ... }: {
  imports = [
    {
      home-manager.users.chandler = {
        imports = [
          ./home.nix
        ];
      };
    }
  ];

  homebrew = {
    taps = [ "encoredev/tap" ];
    casks = [ "balenaetcher" ];
    brews = [ "socat" "encore" ];
  };

  nix.settings.trusted-users = [ "chandler" ];

  services = {
    tailscale = {
      enable = true;
    };
  };

  programs.ssh.extraConfig = ''
    Host bitcrshr-gaming
      HostName 10.69.0.22
      User chandler
      IdentityAgent ~/.1password/agent.sock
  '';
}
