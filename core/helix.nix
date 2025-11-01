{ pkgs, lib, ... }:
let
  yamlToAttrs =
    { input, output }:
    builtins.fromJSON (
      builtins.readFile (pkgs.runCommand output { } ''
        ${pkgs.yq-go}/bin/yq -o json ${input} > $out
      ''
    ));
in
{

  imports = [
    ../theme/catppuccin/helix.nix    
  ];

  home.packages = with pkgs; [
    lazygit
    scooter
  ];


  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    theme =
      let
        catpuccin-yazi = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "yazi";
          rev = "043ffae14e7f7fcc136636d5f2c617b5bc2f5e31";
          sha256 = "sha256-zkL46h1+U9ThD4xXkv1uuddrlQviEQD3wNZFRgv7M8Y=";
        };

        catpuccin-tmtheme = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
          sha256 = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };

        flavor = "frappe";
        accent = "lavender";

        themeConfig = builtins.fromTOML (
          builtins.readFile "${catpuccin-yazi}/themes/${flavor}/catppuccin-${flavor}-${accent}.toml"
        );
      in
      themeConfig // {
        mgr.syntect_theme = "${catpuccin-tmtheme}/themes/Catppuccin ${lib.strings.toUpper (builtins.substring 0 1 flavor)}${builtins.substring 1 (-1) flavor}.tmTheme";
      };
  };

  programs.lazygit = {
    enable = true;
    enableZshIntegration = true;

    settings =
      let
        catpuccin-lazygit = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "lazygit";
          rev = "v2.2.0";
          sha256 = "sha256-mHB4Db71uKblCDab47eBIKd63ekYjvXOqUkY/ELMDQQ=";
        };

        flavor = "frappe";
        accent = "sapphire";

        themeConfig = yamlToAttrs {
          input = "${catpuccin-lazygit}/themes-mergable/${flavor}/${accent}.yml";
          output = "lazygit-theme";
        };
      in
      { } // themeConfig;
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "catppuccin_frappe_transparent";

      editor = {
        bufferline = "always";
        completion-replace = true;
        color-modes = true;
        true-color = true;
        auto-format = true;

        indent-guides = {
          render = true;
          skip-levels = 1;
        };

        soft-wrap.enable = true;

        lsp.display-inlay-hints = true;

        clipboard-provider = "termcode";
      };

      keys = {
        insert.j.k = "normal_mode";

        normal = {
          "_" = "goto_first_nonwhitespace";
          "$" = "goto_line_end";
          "{" = "goto_prev_paragraph";
          "}" = "goto_next_paragraph";

          # lazygit integration
          C-g = [
            ":write-all"
            ":insert-output lazygit >/dev/tty"
            ":redraw"
            ":reload-all"
          ];

          # scooter integration for global find + replace
          C-r = [
            ":write-all"
            ":insert-output scooter --no-stdin >/dev/tty"
            ":redraw"
            ":reload-all"
          ];

          # yazi integration for more powerful file explorer
          space = {
            e = [
              ":sh rm -f /tmp/unique-file-h21a434"
              ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-file-h21a434"
              ":insert-output echo \"x1b[?1049h\" > /dev/tty"
              ":open %sh{cat /tmp/unique-file-h21a434}"
              ":redraw"
              ":set mouse false"
              ":set mouse true"
            ];
          };
        };

        select = {
          "_" = "goto_first_nonwhitespace";
          "$" = "goto_line_end";
          "{" = "goto_prev_paragraph";
          "}" = "goto_next_paragraph";
        };
      };
    };
  };
}
