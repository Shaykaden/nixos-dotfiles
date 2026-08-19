{ pkgs, lib, config, ... }:

{
   # FIXME : marche pas ?
   programs.pay-respects = {
      enable = true;
      # alias = "fuck";
      enableZshIntegration = true;
   };
}