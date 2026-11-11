{
  flake.nixosModules.dolphin = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      kdePackages.dolphin
      kdePackages.qtsvg
      nautilus
    ];
  };
}
