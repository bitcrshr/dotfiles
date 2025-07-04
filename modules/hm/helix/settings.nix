{ pkgs, ... }: {
  programs.helix.settings = {
    theme = "material_palenight";

    editor = {
      true-color = true;
      auto-format = true;
      indent-guides.render = true;
      indent-guides.skip-levels = 1;
      indent-guides.charachter = "▏";

      lsp = {
        display-inlay-hints = true;
      };

      clipboard-provider = "termcode";
    };

    keys = {
      normal = {
        "_" = "goto_first_nonwhitespace";
        "$" = "goto_line_end";
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
      };

      select = {
        "_" = "goto_first_nonwhitespace";
        "$" = "goto_line_end";
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
      };
    };
  };
}
