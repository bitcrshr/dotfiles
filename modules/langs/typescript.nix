{ pkgs, config, ... }:
let
  nodejs = pkgs.nodejs_22;
  nodePackages = pkgs.nodePackages;
in
{
  programs.bun = {
    enable =  true;
  };

  home.packages = with pkgs;  [
    nodejs
    typescript
    typescript-language-server
    nodePackages.prettier
    nodePackages.eslint
  ];

  programs.helix.languages =  [
    {
      name = "typescript";
      language-servers =  [ "typescript-language-server" "eslint" ];
      formatter =  {
        command = "prettier";
        args = [ "--parser" "typescript" ];
      };
      auto-format =  true;
      indent =  {
        tab-width = 4;
        unit = "    ";
      };
    }

    {
      name = "javascript";
      language-servers =  [ "typescript-language-server" "eslint" ];
      formatter =  {
        command = "prettier";
        args = [ "--parser" "typescript" ];
      };
      auto-format =  true;
      indent =  {
        tab-width = 4;
        unit = "    ";
      };
    }
  ];
}
