{ ... }: {
  flake.homeModules.devenv = { pkgs, ... }: {
    home.packages = with pkgs; [
      #secretspec
      devenv
    ];
  };
}
