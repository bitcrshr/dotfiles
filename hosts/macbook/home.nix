{ pkgs, lib, ... }:

{
  programs = {
    zsh = {
      shellAliases = {
        conedit = "tmux new -s dotfiles -c ~/dotfiles -A";
        # darwin-rebuild chowders the .git dir perms if run from within the repo
        update = "cd ~; sudo darwin-rebuild switch --flake '/Users/chandler/dotfiles#macbook' || true; popd > /dev/null";
        src = "source ~/.zshrc";
      };

      initContent = lib.mkOrder 550 ''
        setopt ignore_eof
        export PATH="$PATH:$GHOSTTY_BIN_DIR"
      '';
    };
  };

}
