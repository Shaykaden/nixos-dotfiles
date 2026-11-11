# Socle commun à toute machine, y compris headless (futur NAS).
# Un profil ne fait qu'importer des catégories : aucune configuration concrète ici.
{ self, ... }: {
  flake.nixosModules.base = {
    imports = [
      self.nixosModules.system
    ];
  };

  flake.homeModules.base = {
    imports = [
      self.homeModules.cli
      self.homeModules.system
    ];
  };
}
