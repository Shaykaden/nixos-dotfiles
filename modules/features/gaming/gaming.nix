{ self, ... }: {

  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.gaming-config
  ];

  flake.nixosModules.gaming-config = { pkgs, ... }: {
    boot.kernelModules = [ "ntsync" ]; # enable ntsync (from what I read, it's not on by default)

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
      faugus-launcher
      hydralauncher

      lsfg-vk
      lsfg-vk-ui

      mangohud
      goverlay

      protonup-qt # GUI for installing custom Proton versions like GE_Proton
      steam-run # Use "steam-run ./my-game" to launch in FHS environment used by steam
    ];

    services.flatpak.packages = [
      {
        flatpakref = "https://chrisdkn.github.io/Amethyst-Mod-Manager/amethyst.flatpakref";
        sha256 = "1iwzky2nbd0wp4ydmcbh1ap1rzfa7kr55qfsq9wvm3w3i8bsjqih";
      }
    ];
  };
}
