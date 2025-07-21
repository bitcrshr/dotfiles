{ pkgs, ... }:

{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          # main = { };
          alt = builtins.listToAttrs (builtins.map (key: { name = key; value = "C-${key}"; })
            [ "c" "v" "x" "a" "z" "s" "n" "w" "f" "r" ]);
        };
      };
    };
  };
}
