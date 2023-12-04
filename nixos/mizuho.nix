{ config, pkgs, ... } :

{
  imports = 
    [ 
      ./general.nix
      ./nvidia.nix
    ];

  # ――――――――――
  #  ┌┐┌┌─┐┌─┐
  #  │││├─┤└─┐
  #  ┘└┘┴ ┴└─┘
  # ――――――――――

  fileSystems."/mnt/nas" = {
    device = "//192.168.1.63/nas";
    fsType = "cifs";
    options = [ "username=Lain" "password=2AG@btQV3^Zq#&y3fPbe" "x-systemd.automount" "noauto" "rw" "uid=1000" ];
  };

  # ―――――――――――――
  #  ┬ ┬┌─┐┌─┐┬─┐
  #  │ │└─┐├┤ ├┬┘
  #  └─┘└─┘└─┘┴└─
  # ―――――――――――――

  services.getty.autologinUser = "mizuho";
  security.sudo.wheelNeedsPassword = false;


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
}
