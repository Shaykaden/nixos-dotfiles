{
  flake.nixosModules.flatpak = {
    services.flatpak.enable = true;
    services.flatpak.update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    services.flatpak.uninstallUnmanaged = true;
  };
}
