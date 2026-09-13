{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.phos = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.phosConfiguration
      inputs.nix-index-database.nixosModules.default
      inputs.chaotic.nixosModules.default
      inputs.nix-flatpak.nixosModules.nix-flatpak
    ];
  };
}
