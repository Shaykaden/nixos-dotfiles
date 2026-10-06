{ self, ... }: {
  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.git
  ];

  flake.homeModules.git = { pkgs, ... }: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Shaykaden";
          email = "none@none.com";
        };
        init.defaultBranch = "main";
      };
    };

    home.packages = with pkgs; [
      lazygit
    ];
  };
}
