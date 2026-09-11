{
  pkgs,
  self,
  inputs,
  ...
}:
{

  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.noctalia
  ];

  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.noctalia
  ];

  flake.homeModules.noctalia = { pkgs, ... }: {

    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      #settings = builtins.fromJSON (builtins.readFile ./noctalia.json);
    };
  };

  flake.nixosModules.noctalia = { pkgs, ... }: {
    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };

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

    security.polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          var allowedUsers = ["phos"];

          if (action.id == "org.noctalia.greeter.sync-appearance" &&
              action.lookup("program") == "${pkgs.noctalia-greeter}/bin/noctalia-greeter-apply-appearance" &&
              action.lookup("user") == "root" &&
              subject.local && subject.active &&
              allowedUsers.indexOf(subject.user) >= 0) {
            return polkit.Result.YES;
          }
        });
      '';
    };
  };

}
