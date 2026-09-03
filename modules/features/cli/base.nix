{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.base
  ];

  flake.homeModules.base = { ... }: {
    programs.tealdeer = {
      enable = true;
      enableAutoUpdates = true;
    };
    #home.packages = with pkgs; [
    #tealdeer
    #];
  };
}
