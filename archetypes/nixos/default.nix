{ pkgs, config, lib, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.backupFileExtension = "backup";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.chandler = {
        imports = [
          ../../modules/hm
          ./home-shared.nix
        ];

        home = {
          username = "chandler";
          stateVersion = "25.05";
        };
      };
    }
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;

      plugins = [ "git" ];

      theme = "robbyrussell";
    };
  };

  environment.systemPackages = with pkgs; [
    ghostty
  ];

  users.users.chandler = {
    shell = pkgs.zsh;
  };
}
