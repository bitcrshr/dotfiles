{ pkgs, ... }: {
  home.packages = with pkgs; [
    lazygit    
    yazi
    scooter
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      theme = "material_palenight";

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
