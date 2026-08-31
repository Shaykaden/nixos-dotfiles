{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.dev
  ];

  flake.homeModules.dev = { pkgs, ... }: {
    home.packages = with pkgs; [
      #secretspec
      devenv
    ];
  };
}
