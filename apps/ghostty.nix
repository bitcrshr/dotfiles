{ pkgs, lib, config, system, ... }:
let
  cfg = config.bitbox.apps.ghostty;
  theming = import ../theming { inherit pkgs lib; };
in
{
  options.bitbox.apps.ghostty = {
    enable = lib.mkEnableOption "Enable bitbox ghostty";

    shellIntegration = lib.mkOption {
      type = with lib.types; enum [ "zsh" "bash" "fish" "none" ];      
      default = "zsh";
      example = "zsh";
      description = "Which shell integration to enable, if any.";
    };   

    backgroundOpacity = lib.mkOption {
      type = with lib.types; ints.between 0 100;
      default = 85;
      example = 67;
      description = "The opacity level of the background, as a percentage";
    };   

    mouseScrollMultiplier = lib.mkOption {
      type = with lib.types; numbers.between 0.01 10000;
      default = 0.65;
      example = 1;
      description = "Multiplier for scrolling distance with the mouse wheel.";
    };

    theme = lib.mkOption {
      type = with lib.types; either str path;
      default = if pkgs.stdenv.isDarwin then "catppuccin-frappe" else "Catppuccin Frappe";
      example = "Brogrammer";
      description = "The theme to use. This can be a built-in theme name, a custom name, or an absolute path to a custom theme file.";
    };

    package = lib.mkPackageOption pkgs "ghostty" {
      default = [ (if pkgs.stdenv.isDarwin then "ghostty-bin" else "ghostty") ]; 
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      package = cfg.package;

      enableBashIntegration = cfg.shellIntegration == "bash";
      enableFishIntegration = cfg.shellIntegration == "fish";
      enableZshIntegration = cfg.shellIntegration == "zsh";


      settings = {
        theme = cfg.theme;
        background-opacity = (cfg.backgroundOpacity * 1.0) / 100;
        mouse-scroll-multiplier = cfg.mouseScrollMultiplier;
      };

      themes = {
        catppuccin-frappe = theming.catppuccin.ghostty.frappe;
      };
    };
  };
}
