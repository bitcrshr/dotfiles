{
  homeConfiguration = import ./home.nix;

  darwinConfiguration = import ./configuration.nix;
}
