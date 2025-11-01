{
  programs.helix= {
    themes = {
      catppuccin_frappe_transparent = builtins.fromTOML ''
        inherits="catppuccin_frappe"
        "ui.background"={}
        "ui.statusline"={}
        "ui.bufferline.active"={}
      '';
    };
  };
}
