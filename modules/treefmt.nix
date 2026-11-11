# Formatage du dépôt : `nix fmt`, et check associé pour la validation.
{ inputs, ... }: {
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { config, ... }:
    {
      formatter = config.treefmt.build.wrapper;
      treefmt = {
        projectRootFile = "flake.nix";
        programs.nixfmt.enable = true;
      };
    };
}
