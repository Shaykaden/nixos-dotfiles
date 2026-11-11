{ self, inputs, ... }: {

  flake.homeModules.disk = { pkgs, ... }: {

    home.packages = with pkgs; [
      baobab
    ];
  };
}
