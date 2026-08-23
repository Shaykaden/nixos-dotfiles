{ self, inputs, ... }: {

  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.niriPhos
  ];

  flake.nixosModules.niri = { pkgs, ... }: {
    imports = [ inputs.niri.nixosModules.niri ];
    programs.niri = {
      enable = true;
    };
    xdg = {
      portal = {
        enable = true;
        config.niri = {
          default = ["gnome" "gtk"];
          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        };
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-gtk
        ];
      };
    };
  };

  flake.homeModules.niriPhos = { ... }: {
    imports = [
        self.homeModules.niri
      ];

      programs.niri.settings = {
          outputs."DP-1" = {
            mode = {
              width = 3440;
              height = 1440;
              refresh = 179.989;
            };

            #variable-refresh-rate = true;   # screen flicker, check after driver installation + troubleshooting niri docs
          };
      };
  };

  flake.homeModules.niri = { pkgs, ... }: {
    home.packages = with pkgs; [
      xwayland-satellite # xwayland support
      bibata-cursors
    ];

    programs.niri.settings = {
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        hide-when-typing = true;
        hide-after-inactive-ms = 5000;
      };

      prefer-no-csd = true;

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
          width = 3;
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
            top-left = 10.0;
            top-right = 10.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [ {app-id = "dev.noctalia.Noctalia"; } ];
          open-floating = true;
        }
      ];

      debug.honor-xdg-activation-with-invalid-serial = true;

      layer-rules = [
        {
          matches = [ { namespace = "^noctalia-backdrop"; } ];
          place-within-backdrop = true;
        }
        {
          matches = [ { namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"; } ];
          background-effect.xray = false;
        }
      ];

      input = {
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "10%";
        };
      };

      binds = {
        "Mod+T".action.spawn = "foot";
        "Mod+B".action.spawn = "zen-beta";

        "super+q".action.close-window = {};
        "super+h".action.focus-column-left = {};
        "super+l".action.focus-column-right = {};
        "super+j".action.focus-window-or-workspace-down = {};
        "super+k".action.focus-window-or-workspace-up = {};

        "super+alt+h".action.move-column-left = {};
        "super+alt+l".action.move-column-right = {};
        "super+alt+j".action.move-window-down-or-to-workspace-down = {};
        "super+alt+k".action.move-window-up-or-to-workspace-up = {};

        "super+alt+1".action.move-window-to-workspace = 1;
        "super+alt+2".action.move-window-to-workspace = 2;
        "super+alt+3".action.move-window-to-workspace = 3;
        "super+alt+4".action.move-window-to-workspace = 4;

        # # TODO: add +10% -10% on [ ]
        # # TODO: fix le petit decalement
        "super+alt+u".action.set-column-width = "100%";
        "super+u".action.set-column-width = "50%";
        "super+i".action.set-column-width = "66.667%";
        "super+o".action.set-column-width = "33.333%";
        "super+p".action.set-column-width = "+10%";
        "super+alt+p".action.set-column-width = "-10%";


        "super+1".action.focus-workspace = 1;
        "super+2".action.focus-workspace = 2;
        "super+3".action.focus-workspace = 3;
        "super+4".action.focus-workspace = 4;

        "super+r".action.toggle-overview = {};
        "super+g".action.toggle-window-floating = {};
        "super+f".action.fullscreen-window = {};


        # # TODO : scroll more smooth please
        "super+WheelScrollDown".action.focus-column-right = {};
        "super+WheelScrollUp".action.focus-column-left = {};

        "super+alt+WheelScrollDown".action.focus-workspace-down = {};
        "super+alt+WheelScrollUp".action.focus-workspace-up = {};

        # Noctalia
        "super+space".action.spawn = ["noctalia" "msg" "panel-toggle" "launcher"];
      };

    };

  };

  ########perSystem = { pkgs, lib, self', ...}: {
  ########	packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
  ########		inherit pkgs;
  ########		settings = {
  ########			input.keyboard = {
  ########				xkb.layout = "us,ua";
  ########			};

  ########			layout.gaps = 5;

  ########			binds = {
  ########				"Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
  ########			};
  ########			cursor = {
  ########				#TODO import cursor : theme = "Bibata-Modern-Ice";
  ########				size = 24;
  ########				hide-when-typing = true;
  ########				hide-after-inactive-ms = 5000;
  ########			};

  ########		};

  ########	};
  ########};
}
