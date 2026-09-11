{ ... }: {
  flake.nixosModules.phosConfiguration = { pkgs, ... }: {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/phos/dotfiles"; # sets NH_OS_FLAKE variable for you
      # TODO : add variable for username
    };
  };
}
