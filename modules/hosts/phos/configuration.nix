# Configuration de l'hôte phos : identité de la machine uniquement.
# Le reste vient du profil workstation (modules/profiles/workstation.nix).
{ self, inputs, ... }: {
  flake.nixosModules.phosConfiguration =
    { ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        self.nixosModules.phosHardware # hardware-configuration.nix (généré)
        self.nixosModules.workstation # profil machine : system, desktop, dev, gaming, ai
        ./_hardware.nix # spécificités matérielles de cet hôte
      ];

      networking.hostName = "nixos";

      #==== home-manager configuration
      home-manager.users.phos = self.homeModules.phosConfiguration;

      system.stateVersion = "26.05"; # release d'installation, ne pas modifier
    };

  # replace home.nix
  flake.homeModules.phosConfiguration = {
    imports = [
      self.homeModules.workstation
      ./_niri-home.nix # sortie vidéo de cet hôte
    ];

    home = {
      username = "phos";
      homeDirectory = "/home/phos";
    };

    nixpkgs.config.allowUnfree = true;
    programs.bash.enable = true;
    programs.bash.shellAliases.ll = "ls -l";

    home.stateVersion = "26.05";
  };
}
