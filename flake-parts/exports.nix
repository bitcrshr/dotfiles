{
  flake.modules = {
    home-manager = ../modules/hm;
    archetypes = ../archetypes;
  };

  flake.lib = ../lib;
}
