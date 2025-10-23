{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };

    # .zshenv
    envExtra = ''

    '';

    initContent = ''
      export PATH=$PATH:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin
      export GPG_TTY=$(tty)
      export PATH=$PATH:/usr/local/go/bin
      export PATH=$PATH:$HOME/.local/bin
      export FZF_DEFAULT_COMMAND='fd'
      export EDITOR="hx"

      eval "$(direnv hook zsh)"
    '';
  };
}
