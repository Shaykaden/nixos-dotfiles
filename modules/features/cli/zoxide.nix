{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.zoxide
  ];

  flake.homeModules.zoxide = { pkgs, lib, ... }: {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
