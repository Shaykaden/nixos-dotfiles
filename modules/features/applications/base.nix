{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.base
  ];

  flake.homeModules.base = { pkgs, ... }: {
    home.packages = with pkgs; [
      localsend
    ];
  };
}
