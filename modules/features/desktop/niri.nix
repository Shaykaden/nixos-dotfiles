{ self, inputs, ...}: {

	flake.homeModules.phosConfiguration.imports = [
	  self.homeModules.niri
	];

	flake.nixosModules.niri = {pkgs, lib, ...}: {
	imports = [ inputs.niri.nixosModules.niri ];
	programs.niri = {
	    enable = true;
	  };
	};

	flake.homeModules.niri = {pkgs, ...}: {
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
