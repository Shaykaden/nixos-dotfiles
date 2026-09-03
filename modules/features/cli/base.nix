{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.foot
  ];

  flake.homeModules.foot = { pkgs, ... }: {
    home.packages = with pkgs; [
      nix-index
    ];
  };
}
