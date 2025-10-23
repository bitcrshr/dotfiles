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

  flake.homeConfigurations = {
    generic = self.lib.mkHomeManagerConfiguration { system = "x86_64-linux"; };
  };
}
