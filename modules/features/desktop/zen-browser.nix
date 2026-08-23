{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.zen
  ];

  flake.homeModules.zen = { inputs, ... }: {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      # Betterfox for Zen (yokoffing/Betterfox zen/user.js, aka BetterZen):
      # privacy/telemetry/performance prefs applied as mkDefault settings —
      # any profile `settings` entry wins.
      profiles.default.presets.betterfox.enable = true;
    };
  };
}
