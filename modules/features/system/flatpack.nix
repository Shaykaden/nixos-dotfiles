{ ... }: {
  flake.nixosModules.phosConfiguration = { ... }: {
    # check modules
    services.flatpak.enable = true;
    services.flatpak.update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
    services.flatpak.uninstallUnmanaged = true;

    # Exemple : install a flatpack package
    #services.flatpak.packages = [
    #  # Classic
    #  { appId = "com.brave.Browser"; origin = "flathub";  }
    #  "im.riot.Riot"
    #
    #  # Flatpakref files
    #  { flatpakref = "<uri>"; sha256="<hash>"; }
    #
    #  # bundles
    #  rec {
    #   appId = "<appId>";
    #   sha256 = "<hash>";
    #   bundle = "${pkgs.fetchurl {
    #     url = "<bundle-uri>";
    #     inherit sha256;
    #   }}";
    # }
    #];
  };
}
