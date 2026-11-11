{ ... }: {
  flake.nixosModules.appimage = { ... }: {
    programs.appimage.enable = true;
    programs.appimage.binfmt = true; # permet d'executer ./app.appimage sans utiliser la commande run-appimage

    #home.packages = with pkgs; [
    #webcord-vencord
    #];
  };
}
