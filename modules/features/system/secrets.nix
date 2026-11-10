{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.secrects
  ];

  flake.homeModules.dev = { pkgs, ... }: {
    home.packages = with pkgs; [
      #secretspec
      sops
    ];
  };
}
