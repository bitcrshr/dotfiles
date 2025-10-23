{ pkgs, ... }:

{
  services.keyd = {
    enable = false;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = { };
      };
    };
  };
}
