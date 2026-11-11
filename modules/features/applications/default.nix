# Applications graphiques : navigateur, chat, médias, terminal, gestionnaire de fichiers.
{ self, ... }: {
  flake.nixosModules.applications = {
    imports = [
      self.nixosModules.dolphin
    ];
  };

  flake.homeModules.applications = {
    imports = [
      self.homeModules.zen
      self.homeModules.nixcord
      self.homeModules.media
      self.homeModules.localsend
      self.homeModules.foot
      self.homeModules.disk
    ];
  };
}
