{ config, pkgs, inputs, lib, ... }: 

{
   imports = [
      ./hardware-configuration.nix
      # inputs.xremap-flake.nixosModules.default
   ];


   # ―――――――――――――――――――
   #  ┌─┐┬  ┌─┐┬┌─┌─┐┌─┐  
   #  ├┤ │  ├─┤├┴┐├┤ └─┐  
   #  └  ┴─┘┴ ┴┴ ┴└─┘└─┘  
   # ―――――――――――――――――――

   # Enable Flakes and the new command-line tool
   nix.settings.experimental-features = [ "nix-command" "flakes" ];


   # ――――――――――――――――――――――――――――――――
   #  ┌─┐┌─┐┌┐┌┌─┐┬─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐  
   #  │ ┬├┤ │││├┤ ├┬┘├─┤ │ ││ ││││└─┐  
   #  └─┘└─┘┘└┘└─┘┴└─┴ ┴ ┴ ┴└─┘┘└┘└─┘  
   # ――――――――――――――――――――――――――――――――

   # Limit the number of generations to eep
   boot.loader.systemd-boot.configurationLimit = 10;
   # boot.loader.grub.configurationLimit = 10;

   # Perform garbage collection montlhy to maintain low disk usage
   nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1m";
   };

   # Optimize storage
   nix.settings.auto-optimise-store = true;


   # ――――――――――――――――――――――
   #  ┌─┐┌─┐┌┐┌┌─┐┬─┐┌─┐┬  
   #  │ ┬├┤ │││├┤ ├┬┘├─┤│  
   #  └─┘└─┘┘└┘└─┘┴└─┴ ┴┴─┘
   # ――――――――――――――――――――――

   # Bootloader.
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "nixos";      # Define your hostname.

      # Enable networking
      # TODO: Comment changer ce DNS ? 
      networking = {
         useDHCP = lib.mkDefault true; 
         nameservers = ["1.1.1.1" "1.0.0.1"];         
         resolvconf.enable = pkgs.lib.mkForce false;  
         dhcpcd.extraConfig = "nohook resolv.conf";   
      # networkmanager.dns = "none";
         networkmanager.enable = true;
      };

   services.resolved.enable = false;
   # networking.wireless.enable = true;      
   # Enables wireless support via wpa_supplicant.

   # Configure network proxy if necessary
   # networking.proxy.default = "http://user:password@proxy:port/";
   # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


   # Set your time zone.
   time.timeZone = "Europe/Paris";

   # Select internationalisation properties.
   i18n.defaultLocale = "fr_FR.UTF-8";

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
   services.xserver = {
      layout = "us";
      xkbVariant = "";
   };

   services.gvfs.enable = true;

   environment.sessionVariables = {
      EDITOR = "nvim";
   };

   users.defaultUserShell = pkgs.zsh;

   # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.mizuho = {
      isNormalUser = true;
      description = "mizuho";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      packages = with pkgs; [];
   };

   # ―――――――――――――――――――――――――
   #  ┬ ┬┬ ┬┌─┐┬─┐┬  ┌─┐┌┐┌┌┬┐
   #  ├─┤└┬┘├─┘├┬┘│  ├─┤│││ ││
   #  ┴ ┴ ┴ ┴  ┴└─┴─┘┴ ┴┘└┘─┴┘
   # ―――――――――――――――――――――――――

   programs.hyprland = {
      enable = true;
      xwayland.enable = true;
   };

   hardware.uinput.enable = true;

   users.groups.uinput.members = [ "mizuho" ];
   users.groups.input.members = [ "mizuho" ];

   # services.xremap = {
   #   userName = "mizuho";
   #   serviceMode = "user";        # By default service is runs as root
   #   withHypr = true;
   #   config = {
   #        # https://github.com/k0kubun/xremap #configuration
   #     modmap = [];
   #     keymap = [
   #       {
   #         name = "Firefox";
   #         application = {
   #           only = [
   #             "firefox"
   #           ];
   #         };
   #         remap = {
   #           "ctrl-l" = "ctrl-pagedown";
   #           "ctrl-j" = "ctrl-pageup";
   #         };
   #       }
   #     ];
   #   };
   # };

   # ―――――――――――――
   #  ┌─┐┬┌─┌─┐┌─┐
   #  ├─┘├┴┐│ ┬└─┐
   #  ┴  ┴ ┴└─┘└─┘
   # ―――――――――――――

   # Allow unfree packages
   nixpkgs = {
   # You can add overlays here
   # Configure your nixpkgs instance
      config = {
   # Disable if you don't want unfree packages
         allowUnfree = true;
      };
   };

   programs.dconf.enable = true; 
   programs.thunar.enable = true;

   programs.zsh.enable = true;

   services.flatpak.enable = true;

   # List packages installed in system profile. To search, run:
   # $ nix search wget
   environment.systemPackages = with pkgs; [
   #  vim   # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      mpv
   #  wget
         neovim
         home-manager
         rofi-wayland
         swww
         gtk3

   # qt5.qtwayland
   # qt6.qtwayland
   # qt5
   # qt6
         brave

         fira-code
         fira-code-symbols
         jetbrains-mono
         unzip
         kitty
         samba
         cifs-utils
         firefox
         socat

         glib


         pavucontrol
         pamixer
         git


         (pkgs.waybar.overrideAttrs (oldAttrs: {
                                     mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
                                     })
         )
         ];

   # ――――――――――――――――――――――
   #  ┌─┐┬ ┬┌─┐┌┬┐┌─┐┌┬┐┌─┐
   #  └─┐└┬┘└─┐ │ ├┤ │││└─┐
   #  └─┘ ┴ └─┘ ┴ └─┘┴ ┴└─┘
   # ――――――――――――――――――――――

   xdg.portal.enable = true;
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

   sound.enable = true;
   security.rtkit.enable = true;
   services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
   };

   # This value determines the NixOS release from which the default
   # settings for stateful data, like file locations and database versions
   # on your system were taken. It‘s perfectly fine and recommended to leave
   # this value at the release version of the first install of this system.
   # Before changing this value read the documentation for this option
   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
   system.stateVersion = "23.05";   # Did you read the comment?

   # ――――――――――――――――――――――――――――――――――――
   #  ┌─┐┌┐┌┬  ┬┬┬─┐┌─┐┌┐┌┌┬┐┌─┐┌┐┌┌─┐┌┬┐
   #  ├┤ │││└┐┌┘│├┬┘│ │││││││├┤ │││├┤  │ 
   #  └─┘┘└┘ └┘ ┴┴└─└─┘┘└┘┴ ┴└─┘┘└┘└─┘ ┴
   # ――――――――――――――――――――――――――――――――――――

   virtualisation.docker = {
      enable = true;
      rootless = {
         enable = true;
         setSocketVariable = true;
      };
   };
   users.extraGroups.docker.members = [ "mizuho" ];

   virtualisation.podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
   };


   # nix = {
   #   settings = {
   #     experimental-features = "nix-command flakes";
   #     auto-optimise-store = true;
   #   };
   # };

   containers.vpn = { 
      config =  { config, pkgs, ... }: {
         environment.systemPackages = with pkgs; [
            protonvpn-cli     # Our VPN client
               tmux
               youtube-dl
               aria
         ];
         users.extraUsers.user = {
            isNormalUser = true;
            uid = 1000;
         };
      };
   };
}















