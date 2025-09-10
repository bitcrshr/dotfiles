{ pkgs, ... }:
let
  catpuccin = pkgs.fetchgit {
    url = "https://github.com/catppuccin/waybar.git";
    hash = "sha256-za0y6hcN2rvN6Xjf31xLRe4PP0YyHu2i454ZPjr+lWA=";
  };

  mochaStylePath = builtins.toPath (catpuccin + "/themes/mocha.css");
in
{
  home.file."waybar-catpuccin-mocha" = {
    enable = true;
    source = mochaStylePath;
    target = ".config/waybar/mocha.css";
  };

  programs.waybar.style = ''
    @import "mocha.css";

    * {
      font-family: JetBrainsMonoNL Nerd Font Propo;
      font-size: 17px;
      min-height: 0;
    }

    #waybar {
      background: transparent;
      color: @text;
      margin: 5px 5px;
    }

    #workspaces {
      border-radius: 1rem;
      margin: 5px;
      background-color: @surface0;
      margin-left: 1rem;
    }

    #workspaces button {
      color: @lavender;
      border-radius: 1rem;
      padding: 0.4rem;
    }

    #workspaces button.active {
      color: @sky;
      border-radius: 1rem;
    }

    #workspaces button:hover {
      color: @sapphire;
      border-radius: 1rem;
    }

    #custom-music,
    #tray,
    #clock,
    #pulseaudio,
    #cpu,
    #memory {
      background-color: @surface0;
      padding: 0.5rem 1rem;
      margin: 5px 0;
    }

    #cpu {
      color: @blue;
      border-radius: 1rem 0px 0px 1rem;
      margin-left: 1rem;
    }

    #memory {
      color: @blue;
      border-radius: 0px 1rem 1rem 0px;
      margin-right: 1rem;
    }

    #clock {
      color: @blue;
      border-radius: 0px 1rem 1rem 0px;
      margin-right: 1rem;
    }

    #pulseaudio {
      color: @maroon;
      border-radius: 1rem 0px 0px 1rem;
      margin-left: 1rem;
    }

    #custom-music {
      color: @mauve;
      border-radius: 1rem;
    }

    #custom-lock {
        border-radius: 1rem 0px 0px 1rem;
        color: @lavender;
    }

    #custom-power {
        margin-right: 1rem;
        border-radius: 0px 1rem 1rem 0px;
        color: @red;
    }

    #tray {
      margin-right: 1rem;
      border-radius: 1rem;
    }
  '';
}
