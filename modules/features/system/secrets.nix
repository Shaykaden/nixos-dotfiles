{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.secrets
  ];

  flake.homeModules.secrets = { pkgs, ... }: {
    home.packages = with pkgs; [
      #secretspec
      sops
    ];
  };
}
