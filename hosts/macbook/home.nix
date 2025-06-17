{ pkgs, lib, ... }:

{
  programs = {
    zsh = {
      shellAliases = {
        conedit = "tmux new -s dotfiles -c ~/dotfiles -A";
        update = "sudo darwin-rebuild switch --flake '/Users/chandler/dotfiles#macbook'";
        src = "source ~/.zshrc";
      };

      initContent = lib.mkOrder 550 ''
        setopt ignore_eof
        export PATH="$PATH:$GHOSTTY_BIN_DIR"
      '';
    };
  };

}
