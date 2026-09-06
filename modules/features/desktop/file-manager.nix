{ self, ... }: {
  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.dolphin
  ];

  flake.nixosModules.dolphin = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      kdePackages.dolphin # This is the actual dolphin package
      kdePackages.qtsvg
    ];
  };
}
