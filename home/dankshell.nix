{ pkgs, inputs, ...}: {
	home.packages = with pkgs; [
		imagemagickBig
		swaybg
		jq
	];
	imports = [
		inputs.dankMaterialShell.homeModules.dankMaterialShell.default
		inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
	];

	programs.dankMaterialShell = { 
		enable = true;
		# TODO : config in here;
		niri = {
			enableSpawn = true;      # Auto-start DMS with niri
		};

		systemd = {
			#enable = true;             # Systemd service for auto-start
			restartIfChanged = true;   # Auto-restart dms.service when dankMaterialShell changes
		};

		default.settings = {
			theme = "dark";
			dynamicTheming = true;
			# Add any other settings here
		};

		# Core features
		enableSystemMonitoring = true;     # System monitoring widgets (dgop)
		enableClipboard = true;            # Clipboard history manager
		enableVPN = true;                  # VPN management widget
		enableBrightnessControl = true;    # Backlight/brightness controls
		enableColorPicker = true;          # Color picker tool
		enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
		enableAudioWavelength = true;      # Audio visualizer (cava)
		enableCalendarEvents = true;       # Calendar integration (khal)
		enableSystemSound = true;          # System sound effects
  };


	# TODO : mettre dans un fichier separer

	# programs.dankMaterialShell.greeter = {
	# 	enable = true;
	# 	compositor.name = "niri";  # Or "hyprland" or "sway"
	# 	  # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
	# 	configHome = "/home/rutile";
	# };
}
