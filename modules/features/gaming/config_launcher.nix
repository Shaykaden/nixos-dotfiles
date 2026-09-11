{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.osu
  ];

  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.opentabletdriver
  ];

  flake.homeModules.osu = { pkgs, ... }: {
    home.packages = with pkgs; [
      osu-lazer-bin
    ];
  };

  flake.nixosModules.opentabletdriver = { pkgs, ... }: {
    programs.gamemode.enable = true; # for performance mode
    programs.gamescope.enable = true;

    programs.steam = {
      enable = true; # install steam
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    programs.steam.extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    environment.systemPackages = with pkgs; [
      (heroic.override {
        # install heroic launcher
        extraPkgs =
          pkgs': with pkgs'; [
            gamescope
            gamemode
          ];
      })
      lutris # install lutris launcher
      faugus-launcher
      protonup-qt # GUI for installing custom Proton versions like GE_Proton
      steam-run # Use "steam-run ./my-game" to launch in FHS environment used by steam
    ];
  };
}
