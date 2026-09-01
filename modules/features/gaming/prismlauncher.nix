{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.prismlauncher
  ];

  flake.homeModules.prismlauncher = { pkgs, ... }: {
    home.packages = with pkgs; [
      (prismlauncher.override {
        jdks = [
          zulu17 # from 1.18   to 1.20.4
          zulu21 # from 1.20.5 to 1.21.11
          zulu25 # since 26.1
        ];
      })
    ];
  };
}
