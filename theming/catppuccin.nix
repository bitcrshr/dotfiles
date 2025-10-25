{ pkgs, lib, ... }:
let
  flavors = [ "frappe" "latte" "macchiato" "mocha" ];
in
{
  ghostty =
    let
      repo = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "ghostty";
        rev = "0eeefa637affe0b5f29d7005cfe4e143c244a781";
        sha256 = "sha256-j0HCakM9R/xxEjWd5A0j8VVlg0vQivjlAYHRW/4OpGU=";
      };

      # i hate myself for doing this
      flavorToFile = builtins.listToAttrs (
        builtins.map (flavor:
          {
            name = flavor;
            value = builtins.readFile "${repo}/themes/catppuccin-${flavor}.conf";
          }
        ) flavors
      );

      fileToAttrs = file: builtins.listToAttrs (
        builtins.map
          (kvList:
            {
              name = (builtins.elemAt kvList) 0;
              value = (builtins.elemAt kvList) 1;
            }
          )
          (builtins.map (line: lib.splitString " = " line) (builtins.filter (l: (builtins.stringLength l) > 0) (lib.splitString "\n" file)))
      );
    in
    builtins.mapAttrs (name: value: fileToAttrs value) flavorToFile;
}
