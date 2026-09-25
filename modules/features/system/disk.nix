{ self, inputs, ... }: {

  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.disk
  ];

  flake.homeModules.disk = { pkgs, ... }: {

    home.packages = with pkgs; [
      baobab
    ];
  };
}
