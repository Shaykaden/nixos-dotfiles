# Outils de développement.
{ self, ... }: {
  flake.nixosModules.dev = {
    imports = [
      self.nixosModules.unity
    ];
  };

  flake.homeModules.dev = {
    imports = [
      self.homeModules.devenv
      self.homeModules.zed
      self.homeModules.unity
    ];
  };
}
