# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, outputs, lib, config, pkgs, packages, ... }: 

{
  imports = [
    ./cli
    ./dev
    ./fonts
    ./desktop
    ./casual
  ];

  home = {
    username = "mizuho";
    homeDirectory = "/home/mizuho";
  };

  home.sessionVariables = {
    EDITOR = "vim";
    SHELL = "zsh";
  };

  nixpkgs.config = {
      allowUnfree = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
