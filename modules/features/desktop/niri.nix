{ self, inputs, ... }: {

  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.niri
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

  flake.homeModules.niri = { pkgs, ... }: {
    home.packages = with pkgs; [
      xwayland-satellite # xwayland support
    ];

    programs.niri.settings = {
      layout.gaps = 16;

      binds = {
        "Mod+T".action.spawn = "foot";
        "Mod+B".action.spawn = "librewolf";
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
