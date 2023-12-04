{ pkgs, ... }: 

{
  imports = [
    ./discord.nix
    ./boshi.nix
    # ./steam.nix
  ];

  home.packages = with pkgs; [
    # Application
    appflowy
    vlc
    anki

    # Game
    osu-lazer-bin
    minecraft
    prismlauncher
    taisei

    #media
    plex
    plex-media-player


    protonvpn-gui
  ];
}
