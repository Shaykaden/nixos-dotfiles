{ self, inputs, ... }: {

  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.noctalia
  ];

  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.noctalia-greetd
  ];

  flake.homeModules.noctalia = { pkgs, ... }: {

    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      #settings = builtins.fromJSON (builtins.readFile ./noctalia.json);
    };
  };

  flake.nixosModules.noctalia-greetd = { pkgs, ... }: {
    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        cursor.size = 24;
        keyboard.layout = "us";
      };
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
      };
    };
  };
}
