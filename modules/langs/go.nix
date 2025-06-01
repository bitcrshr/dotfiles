{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go_1_24
  ];

  programs.helix.languages = {
    language-server.gopls = {
      goimports =  true;
      gofumpt =  true;
      staticcheck =  false;
    };

    language = [
      {
        name = "go";
        auto-format =  true;
        formatter =  { command = "goimports"; };
      }
    ];
  };

  programs.zsh.initExtra =  ''
    export GOPATH="$HOME/go"
    export PATH="$GOPATH/bin:$PATH"
  '';
}
