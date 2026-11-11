{ ... }: {
  flake.nixosModules.phosConfiguration = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      atkinson-hyperlegible-next
    ];
  };
}
