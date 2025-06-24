{ pkgs, config, ... }: {
  imports = [
    ../../archetypes/mac.nix

    {
      home-manager.users.chandler = {
        imports = [
          ../../modules/hm
          ../../modules/hm/profiles/personal.nix
          ./home.nix
        ];

        home = {
          username = "chandler";
          stateVersion = "25.05";
        };

        systemd.user.startServices = "sd-switch";
      };
    }
  ];
}
