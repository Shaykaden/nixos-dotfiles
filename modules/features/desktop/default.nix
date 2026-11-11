# Session graphique : compositeur, shell, portails, audio, polices.
{ self, ... }: {
  flake.nixosModules.desktop = {
    imports = [
      self.nixosModules.niri
      self.nixosModules.noctalia
      self.nixosModules.xremap
      self.nixosModules.appimage
      self.nixosModules.audio
      self.nixosModules.flatpak
      self.nixosModules.fonts
      self.nixosModules.misc-usr-fix
    ];
  };

  flake.homeModules.desktop = {
    imports = [
      self.homeModules.niri
      self.homeModules.noctalia
    ];
  };
}
