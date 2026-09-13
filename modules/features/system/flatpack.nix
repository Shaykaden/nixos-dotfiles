{ ... }: {
  flake.nixosModules.flatpack = { }: {
    # check modules
    services.flatpak.enable = true;
  };
}
