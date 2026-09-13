{ ... }: {
  flake.nixosModules.flatpack = { }: {
    # check modules
    services.flatpak.enable = true;
    services.flatpak.update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    services.flatpak.uninstallUnmanaged = true;

    # Exemple : install a flatpack package
    #services.flatpak.packages = [
    #  "im.riot.Riot"
    #];
  };
}
