{ inputs, self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.nixcord
  ];

  flake.homeModules.media = { pkgs, ... }: {
    imports = [ inputs.nixcord.homeModules.nixcord ];

    home.packages = with pkgs; [
      plex-desktop
      plezy
    ];
  };
}
