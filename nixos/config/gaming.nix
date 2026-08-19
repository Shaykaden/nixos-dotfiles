
{ config, pkgs, inputs, outputs, ... }:

{
  hardware.graphics.enable = true;

  programs.steam = {
    enable = true; # install steam
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # TODO : see nix-gaming on github
    #platformOptimizations.enable = true;
  };

  programs.steam.gamescopeSession.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
        pkgs.gamemode
        pkgs.mangohud
      ];
    })
  ];

  programs.gamemode.enable = true; # for performance mode
  programs.gamescope.enable = true;

  services.tailscale.enable = true;
  services.tailscale.extraDaemonFlags = ["--no-logs-no-support"];
}
