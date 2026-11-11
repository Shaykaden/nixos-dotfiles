{ inputs, ... }: {
  flake.homeModules.nixcord = { pkgs, ... }: {

    imports = [ inputs.nixcord.homeModules.nixcord ];

    programs.nixcord = {
      enable = true;

      discord = {
        krisp.enable = true;
        equicord.enable = true;
        openASAR.enable = true;
      };

      # TODO : Config plugins, etc
    };
  };
}
