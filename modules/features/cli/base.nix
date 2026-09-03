{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.base
  ];

  flake.homeModules.base = { ... }: {
    programs.tealdeer = {
      enable = true;
      #enableAutoUpdates = true; #Does not work ?
      settings = {
        updates = {
          auto_update = true;
        };
      };
    };
    #home.packages = with pkgs; [
    #tealdeer
    #];
  };
}
