{ ... }: {
  flake.homeModules.secrets = { pkgs, ... }: {
    home.packages = with pkgs; [
      #secretspec
      sops
    ];
  };
}
