{ config, pkgs, inputs, outputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./sound.nix
      ./xremap.nix
      ./gaming.nix
    ];

  # import vim pkgs
  environment.systemPackages = with pkgs; [
    libnotify
    aegisub
    mpv
    mkvtoolnix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-36.9.5"
  ];



  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.atkynson-mono
    atkinson-hyperlegible-next
  ];
}
