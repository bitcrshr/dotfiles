{ self, ... }:
{
  flake.nixosConfigurations = {
    bitcrshr-gaming = self.lib.mkNixOsConfiguration {
      hostname = "bitcrshr-gaming";
      modules = [ ../machines/nixos/gaming ];
    };
  };

  flake.darwinConfigurations = {
    macbook = self.lib.mkDarwinConfiguration {
      
    };
  };
}
