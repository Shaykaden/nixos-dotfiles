# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ self, inputs, ... }: {
  flake.nixosModules.phosConfiguration =
    { pkgs, ... }:
    {
      imports = [
        # Include the results of the hardware scan.
        inputs.home-manager.nixosModules.home-manager
        self.nixosModules.phosHardware
        self.nixosModules.niri
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.allowUnfree = true;

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      networking.hostName = "nixos"; # Define your hostname.
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Enable networking
      networking.networkmanager.enable = true;

      # Set your time zone.
      time.timeZone = "Europe/Paris";

      # Select internationalisation properties.
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

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users."phos" = {
        isNormalUser = true;
        description = "Phos";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      # List packages installed in system profile. To search, run:
      # $ nix search wget
      environment.systemPackages = with pkgs; [
        neovim
        #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        #  wget
      ];

      programs.zsh.enable = true;
      users.defaultUserShell = pkgs.zsh;
      environment.shells = with pkgs; [ zsh ]; # From doc : To add the zsh package to /etc/shells you must update environment.shells.

      #==== home-manager configuration
      home-manager.users.phos = self.homeModules.phosConfiguration;
      # Some programs need SUID wrappers, can be configured further or are
      # started in user sessions.
      # programs.mtr.enable = true;
      # programs.gnupg.agent = {
      #   enable = true;
      #   enableSSHSupport = true;
      # };

      # List services that you want to enable:

      # Enable the OpenSSH daemon.
      # services.openssh.enable = true;

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

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
    home = {
      username = "phos";
      homeDirectory = "/home/phos";
    };

    imports = [
      self.homeModules.desktop
    ];
    nixpkgs.config.allowUnfree = true;
    programs.bash.enable = true;
    programs.bash.shellAliases.ll = "ls -l";

    home.stateVersion = "26.05";
  };
}
