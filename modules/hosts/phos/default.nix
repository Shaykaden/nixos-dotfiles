{ self, inputs, ... }: {
  flake.nixosConfigurations.phos = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.phosConfiguration
    ];
  };
}
