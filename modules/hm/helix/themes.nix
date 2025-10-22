{
  programs.helix.themes = {
    halloween = builtins.fromTOML ''
      # Halloween Dark Theme for Helix Editor
      # A pleasant dark theme with Halloween-inspired colors
      # Deep purples, oranges, ghostly whites, and eerie greens

      "ui.background" = { bg = "#1a0f1f", fg = "#d4c5d9" }
      "ui.background.separator" = { fg = "#4a3556" }
      "ui.text" = { fg = "#c0b0c8" }
      "ui.text.focus" = { fg = "#e8dce8" }
      "ui.menu" = { bg = "#231829", fg = "#d4c5d9" }
      "ui.menu.selected" = { bg = "#6b3fa0", fg = "#ffffff" }
      "ui.menu.scroll" = { fg = "#8a7a94" }
      "ui.linenr" = { fg = "#574765", modifiers = ["dim"] }
      "ui.linenr.selected" = { fg = "#ff8c42", modifiers = ["bold"] }
      "ui.popup" = { bg = "#231829", fg = "#d4c5d9" }
      "ui.window" = { fg = "#3d2f47" }
      "ui.selection" = { bg = "#3d2652" }
      "comment" = { fg = "#7a6885", modifiers = ["italic"] }
      "ui.statusline" = { bg = "#2d1f3a", fg = "#d4c5d9" }
      "ui.statusline.inactive" = { bg = "#1a0f1f", fg = "#6b5a75" }
      "ui.statusline.normal" = { bg = "#6b3fa0", fg = "#ffffff" }
      "ui.statusline.insert" = { bg = "#4caf50", fg = "#1a0f1f" }
      "ui.statusline.select" = { bg = "#ff6b35", fg = "#1a0f1f" }
      "ui.help" = { bg = "#231829", fg = "#c0b0c8" }
      "ui.cursor" = { modifiers = ["reversed"] }
      "ui.cursor.match" = { bg = "#ff8c42", fg = "#1a0f1f" }
      "ui.cursor.primary" = { modifiers = ["reversed", "slow_blink"] }
      "ui.cursor.secondary" = { bg = "#6b3fa0", fg = "#ffffff" }
      "ui.cursorline.primary" = { bg = "#241832" }
      "ui.cursorline.secondary" = { bg = "#1f1528" }
      "ui.cursorcolumn.primary" = { bg = "#241832" }
      "ui.cursorcolumn.secondary" = { bg = "#1f1528" }
      "ui.virtual.ruler" = { bg = "#2a1d35" }
      "ui.virtual.whitespace" = { fg = "#3d2f47" }
      "ui.virtual.indent-guide" = { fg = "#3d2f47" }
      "ui.virtual.inlay-hint" = { fg = "#8a7a94", bg = "#241832" }
      "ui.virtual.inlay-hint.parameter" = { fg = "#9a8aa4", bg = "#241832" }
      "ui.virtual.inlay-hint.type" = { fg = "#9a8aa4", bg = "#241832" }
      "ui.virtual.wrap" = { fg = "#3d2f47" }
      "ui.virtual.jump-label" = { fg = "#ff8c42", modifiers = ["bold", "underlined"] }

      # Syntax highlighting - Halloween themed
      "variable" = "#e8a5c5"
      "variable.other.member" = "#a8d5ba"
      "constant.numeric" = "#ffb347"
      "constant" = "#ffb347"
      "attribute" = "#ff8c42"
      "type" = "#f4a261"
      "string" = "#81c784"
      "constant.character.escape" = "#4dd0e1"
      "function" = "#9575cd"
      "constructor" = "#ba68c8"
      "special" = "#7e57c2"
      "keyword" = "#ff6b6b"
      "label" = "#ff8a80"
      "namespace" = "#ce93d8"
      "operator" = "#b39ddb"

      # Markup
      "markup.heading" = { fg = "#ff8c42", modifiers = ["bold"] }
      "markup.list" = "#ff6b6b"
      "markup.bold" = { fg = "#ffb347", modifiers = ["bold"] }
      "markup.italic" = { fg = "#ce93d8", modifiers = ["italic"] }
      "markup.strikethrough" = { fg = "#8a7a94", modifiers = ["crossed_out"] }
      "markup.link.url" = { fg = "#9575cd", underline = { color = "#9575cd", style = "line" } }
      "markup.link.text" = "#4dd0e1"
      "markup.quote" = { fg = "#81c784", modifiers = ["italic"] }
      "markup.raw" = "#a8d5ba"
      "markup.normal" = { fg = "#c0b0c8" }
      "markup.insert" = { fg = "#81c784" }
      "markup.select" = { fg = "#ff8c42" }

      # Diff
      "diff.plus" = "#81c784"
      "diff.delta" = "#ffb347"
      "diff.delta.moved" = "#9575cd"
      "diff.minus" = "#ff6b6b"

      # Diagnostics and messages
      "ui.gutter" = { bg = "#1a0f1f" }
      "info" = "#4dd0e1"
      "hint" = "#9a8aa4"
      "debug" = "#8a7a94"
      "warning" = "#ffb347"
      "error" = "#ff6b6b"

      "diagnostic.info" = { underline = { color = "#4dd0e1", style = "dotted" } }
      "diagnostic.hint" = { underline = { color = "#9a8aa4", style = "double_line" } }
      "diagnostic.debug" = { underline = { color = "#8a7a94", style = "dashed" } }
      "diagnostic.warning" = { underline = { color = "#ffb347", style = "curl" } }
      "diagnostic.error" = { underline = { color = "#ff6b6b", style = "curl" } }
    '';
  };
}
