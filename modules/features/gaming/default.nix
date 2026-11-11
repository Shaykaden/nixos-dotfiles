# Jeux et périphériques de jeu.
{ self, ... }: {
  flake.nixosModules.gaming = {
    imports = [
      self.nixosModules.gaming-system
      self.nixosModules.opentabletdriver
    ];
  };

  flake.homeModules.gaming = {
    imports = [
      self.homeModules.osu
      self.homeModules.prismlauncher
    ];
  };
}
