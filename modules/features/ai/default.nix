# Outils d'IA locale et agents.
{ self, ... }: {
  flake.nixosModules.ai = {
    imports = [
      self.nixosModules.hermes
      self.nixosModules.comfyui
    ];
  };

  flake.homeModules.ai = {
    imports = [
      self.homeModules.hermes
    ];
  };
}
