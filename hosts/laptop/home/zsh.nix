{ pkgs, lib, ... }:
let
  defaults = (import ../../../modules/zsh.nix { inherit pkgs lib; }).programs.zsh;
in
{
  programs.zsh = lib.mkMerge [
    defaults

    {
      shellAliases = {
        conedit = "hx /Users/chandler/dotfiles";
        update = "sudo darwin-rebuild switch --flake '/Users/chandler/dotfiles#Chandlers-MacBook'";
        src = "source ~/.zshrc";
      };

      initContent = lib.mkOrder 550 ''
        setopt ignore_eof
        export PATH="$PATH:$GHOSTTY_BIN_DIR"
      '';
    }
  ];
}
