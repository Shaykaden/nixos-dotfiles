{ inputs, ... }: {
  flake.homeModules.media = { pkgs, ... }: {
    home.packages = with pkgs; [
      plex-desktop
      plezy
    ];
  };
}
