{ pkgs, ... }:
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
      export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/run/wrappers/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin
      export GPG_TTY=$(tty)
      export PATH=$PATH:/usr/local/go/bin
      export PATH=$PATH:$HOME/.local/bin
      export FZF_DEFAULT_COMMAND='fd'

      eval "$(direnv hook zsh)"
    '';
  };
}
