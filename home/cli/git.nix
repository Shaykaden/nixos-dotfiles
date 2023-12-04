{ pkgs, lib, config, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    aliases = {
      lg = "lazygit";
    };
    userName = "Shaykaden";
    userEmail = "shaykaden85@protonmail.com";
  };

  home.packages = [
    pkgs.lazygit
  ];
}
