{ ... }: {
  flake.homeModules.tealdeer = { ... }: {
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
