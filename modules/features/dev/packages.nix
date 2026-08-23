{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.zsh
  ];

  flake.homeModules.zsh = { pkgs, ... }: {
    home.packages = with pkgs; [
      secretspec
    ];
  };
}
