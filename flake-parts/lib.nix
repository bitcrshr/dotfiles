{ inputs, self, ... }:
{
  flake.lib = {
    mkNixOsConfiguration =
      {
        hostname,
        system ? "x86_64-linux",
        nixpkgs ? inputs.nixpkgs,
        home-manager ? inputs.home-manager,
        modules ? [ ],
        user ? "chandler",
      }:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          # shared nixos config
          (
            { pkgs, ... }:
            {
              networking.hostName = hostname;

              nix.settings = {
                experimental-features = [
                  "nix-command"
                  "flakes"
                ];
              };

              environment.systemPackages = with pkgs; [
                ghostty
              ];

              programs.zsh = {
                enable = true;
                ohMyZsh = {
                  enable = true;
                  plugins = [ "git" ];
                  theme = "robbyrussell";
                };
              };

              users.users.${user}.shell = pkgs.zsh;
            }
          )

          inputs.disko.nixosModules.disko

          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users.${user} = {
              imports = [
                self.homeModules.default
              ];

              home.stateVersion = "25.05";
            };
          }
        ]
        ++ modules;
      };

    mkDarwinConfiguration =
      {
        hostname,
        nix-darwin ? inputs.nix-darwin,
        nixpkgs ? inputs.nixpkgs,
        home-manager ? inputs.home-manager,
        modules ? [ ],
        system ? "aarch64-darwin",
        user ? "chandler",
        usingDeterminate ? true,
      }:
      nix-darwin.lib.darwinSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          # shared darwin config
          (
            { pkgs, ... }:
            {
              nix.enable = !usingDeterminate;

              homebrew = {
                enable = true;

                onActivation.cleanup = "zap";

                casks = [
                  "rectangle"
                  "ghostty"
                  "spotify"
                  "zen"
                  "appcleaner"
                  "obsidian"
                ];
              };

              users.users.${user} = {
                home = "/Users/${user}";
                packages = with pkgs; [
                  stats
                  raycast
                ];
              };

              system = {
                primaryUser = user;
                stateVersion = 6;
              };

              nixpkgs = {
                hostPlatform = system;
                config.allowUnfree = true;
              };

              # let home-manager manage zsh
              programs.zsh.enable = false;

              home-manager.users.${user} = {
                home = {
                  username = user;
                  stateVersion = "25.05";
                };

                systemd.user.startServices = "sd-switch";

                programs.zsh = {
                  # macos already comes with zsh
                  package = pkgs.emptyDirectory;

                  initContent = ''
                    setopt ignore_eof
                    export PATH="$PATH:/run/current-system/sw/bin"
                    export PATH="$PATH:$GHOSTTY_BIN_DIR"
                    export PATH="$PATH:/opt/homebrew/bin"
                  '';

                  lsd = {
                    enable = true;
                    enableZshIntegration = true;
                  };
                };
              };
            }
          )

          home-manager.darwinModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };

            home-manager.users.${user} = {
              imports = [
                self.homeModules.default
              ];

              home.stateVersion = "25.05";
            };
          }
        ]
        ++ modules;
      };
  };
}
