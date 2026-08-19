# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ./niri/niri.nix
    ./dankshell.nix
    ./cli/default.nix
    ./browser/zen.nix 
  ];

  home.packages = with pkgs; [
    webcord-vencord
    unrar
    wlr-randr
    kdePackages.dolphin # This is the actual dolphin package
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  # TODO: Set your username
  home = {
    username = "rutile";
    homeDirectory = "/home/rutile";
  };

  # TODO : est-ce que ca sert a quelque chose ?
  home.sessionVariables = {
    EDITOR = "nvim";
    SHELL = "zsh";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";


  # TODO : change location 
  services.flameshot = {
    enable = true;

    # Enable wayland support with this build flag
    package = pkgs.flameshot.override {
      enableWlrSupport = true;
    };

    settings = {
      General = {
        disabledTrayIcon = false;
        showStartupLaunchMessage = false;

        # Auto save to this path
        savePath = "~/Pictures/screenshots";
        savePathFixed = true;
        saveAsFileExtension = ".jpg";
        filenamePattern = "%F_%H-%M";
        drawThickness = 1;
        copyPathAfterSave = true;

        # For wayland
        useGrimAdapter = true;
      };
    };
  };

  # Hide the flameshot wayland warning (https://github.com/flameshot-org/flameshot/issues/3186)
  services.dunst.settings.ignore_flameshot_warning = {
    body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
    format = "";
  };
}
