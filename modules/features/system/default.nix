# Socle système commun à toute machine NixOS (poste, serveur, futur NAS).
# Réutilisable tel quel : rien ici n'est propre à un hôte.
{ self, ... }: {
  flake.nixosModules.system =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.nh
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.allowUnfree = true;

      # Bootloader systemd-boot, 20 entrées max
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.configurationLimit = 20;

      # GC hebdomadaire : purge ce qui dépasse 90 jours
      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 90d";
      };

      networking.networkmanager.enable = true;

      time.timeZone = "Europe/Paris";

      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
      };

      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      users.users."phos" = {
        isNormalUser = true;
        description = "Phos";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      environment.systemPackages = with pkgs; [
        neovim
      ];

      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;
      environment.shells = [ pkgs.zsh ];
    };

  flake.homeModules.system = {
    imports = [
      self.homeModules.secrets
    ];
  };
}
