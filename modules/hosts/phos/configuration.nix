# Configuration de l'hôte phos : identité de la machine uniquement.
# Le reste vient du profil workstation (modules/profiles/workstation.nix).
{ self, inputs, ... }: {
  flake.nixosModules.phosConfiguration =
    { ... }:
    {
      imports = [
        # Include the results of the hardware scan.
        inputs.home-manager.nixosModules.home-manager
        self.nixosModules.phosHardware # hardware-configuration.nix (généré)
        self.nixosModules.workstation # profil machine : system, desktop, dev, gaming, ai
        ./_hardware.nix # spécificités matérielles de cet hôte
      ];

      networking.hostName = "nixos";

      #==== home-manager configuration
      home-manager.users.phos = self.homeModules.phosConfiguration;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "26.05"; # Did you read the comment?
    };

  # replace home.nix
  flake.homeModules.phosConfiguration = { ... }: {
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
