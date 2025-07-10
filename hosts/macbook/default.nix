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
    casks = [ "balenaetcher" "1password" ];
    brews = [ "socat" ];
  };

  services = {
    tailscale = {
      enable = true;
    };
  };

}
