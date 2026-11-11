# Poste de travail complet : socle + session graphique + outillage.
{ self, ... }: {
  flake.nixosModules.workstation = {
    imports = [
      self.nixosModules.base
      self.nixosModules.desktop
      self.nixosModules.applications
      self.nixosModules.dev
      self.nixosModules.gaming
      self.nixosModules.ai
    ];
  };

  flake.homeModules.workstation = {
    imports = [
      self.homeModules.base
      self.homeModules.desktop
      self.homeModules.applications
      self.homeModules.dev
      self.homeModules.gaming
      self.homeModules.ai
    ];
  };
}
