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
        export PATH="$PATH:/opt/homebrew/bin"
        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
      '';
    };

    lsd = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.packages = with pkgs; [
    postman
    zed-editor
  ];
}
