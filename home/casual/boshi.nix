{ pkgs, ... }:

{

  home.packages = with pkgs; [
    aegisub
    mkvtoolnix
  ];
}
