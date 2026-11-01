{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.unity
  ];

  flake.homeModules.unity = { pkgs, ... }: {
    home.packages = with pkgs; [
      unityhub
    ];
  };
}
