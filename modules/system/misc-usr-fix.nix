# CHECK : https://wiki.nixos.org/wiki/Fixes_for_non-Nix_applications
{ ... }: {
  flake.nixosModules.phosConfiguration =
    { pkgs, ... }:
    let
      # Mount options for the bind mounts
      mountOptions = [
        "ro"
        "x-gvfs-hide"
        # Resolves symlinks as if they were real files
        # Needed for things like OnlyOffice
        "resolve-symlinks"
      ];
    in
    {
      # Expose all fonts
      fonts.fontDir.enable = true;

      # Make bindfs available
      system.fsPackages = [ pkgs.bindfs ];

      # Fonts
      fileSystems."/usr/share/fonts" = {
        device = "/run/current-system/sw/share/X11/fonts";
        fsType = "fuse.bindfs";
        options = mountOptions;
      };

      # Icons
      fileSystems."/usr/share/icons" = {
        device = "/run/current-system/sw/share/icons";
        fsType = "fuse.bindfs";
        options = mountOptions;
      };

      # Themes
      fileSystems."/usr/share/themes" = {
        device = "/run/current-system/sw/share/themes";
        fsType = "fuse.bindfs";
        options = mountOptions;
      };
    };
}
