{ config, pkgs, inputs, outputs, ... }:
{
  imports = [
    inputs.niri.homeModules.niri
    ./keybinds.nix
    ./autostart.nix
  ];

  # install bibata cursor via pkgs
  home.packages = with pkgs; [
    bibata-cursors
    xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    # package = pkgs.niri-unstable;


    settings = {
      outputs."eDP-1".enable = true;
      outputs."HDMI-A-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.000;
        };
        focus-at-startup = true;
        scale = 1;
      };
      outputs."DP-2" = {
        mode = {
          width = 3440;
          height = 1440;
          refresh = 179.989;
        };
        # FIXME : check vrr
        # variable-refresh-rate = true;
        focus-at-startup = true;
        scale = 1.15;
      };
      outputs."DP-3" = {
        mode = {
          width = 3440;
          height = 1440;
          refresh = 179.989;
        };
        # FIXME : check vrr
        # variable-refresh-rate = true;
        focus-at-startup = true;
        scale = 1.15;
      };

      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        hide-when-typing = true;
        hide-after-inactive-ms = 5000;
      };

      prefer-no-csd = true;

      hotkey-overlay.skip-at-startup = true;

      layout = {
        background-color = "#000000";
        gaps = 16;
        center-focused-column = "never";
        always-center-single-column = true;
        # FIXME : check default-column-display
        preset-column-widths = [
          { proportion = 1. / 3.; }
          { proportion = 1. / 2.; }
          { proportion = 2. / 3.; }
        ];
        default-column-width = {
          proportion = 2. / 3.;
        };

        border = {
          enable = false;
        };
        focus-ring = {
          enable = true;
          width = 5;
          active.color = "#10101055";
        };

        shadow = {
          enable = false;
          softness = 1;
          spread = 20;
          offset = {
            x = 0;
            y = 0;
          };
        };
        tab-indicator.enable = false;
      };

      window-rules = [
        {
          matches = [ { } ];
          geometry-corner-radius = {
            top-left = 15.0;
            top-right = 15.0;
            bottom-left = 15.0;
            bottom-right = 15.0;
          };
          clip-to-geometry = true;
        }
      ];

      layer-rules = [
        {
          matches = [ { namespace = "^quickshell$"; } ];
          place-within-backdrop = false;
        }
        {
          matches = [ { namespace = "dms:blurwallpaper"; } ];
          place-within-backdrop = true;
        }
      ];
      environment = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";

        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        DISPLAY = ":0";
      };
    };

  };
}
