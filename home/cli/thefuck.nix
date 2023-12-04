{ pkgs, lib, config, ... }:

{
   programs.thefuck = {
      enable = true;
      enableZshIntegration = true;
   };
}
