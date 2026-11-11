# Outils en ligne de commande.
{ self, ... }: {
  flake.homeModules.cli = {
    imports = [
      self.homeModules.git
      self.homeModules.zsh
      self.homeModules.starship
      self.homeModules.zoxide
      self.homeModules.tealdeer
      self.homeModules.packages
    ];
  };
}
