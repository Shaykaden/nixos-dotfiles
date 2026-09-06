{ ... }: {
  flake.nixosModules.phosConfiguration = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-moo
      atkinson-hyperlegible-next
    ];
  };
}
