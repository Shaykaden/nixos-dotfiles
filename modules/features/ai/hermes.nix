{ self, inputs, ... }: {
  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.hermes
  ];

  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.hermes
  ];

  flake.nixosModules.hermes = { ... }: {
    users.users.phos.linger = true;
  };

  flake.homeModules.hermes = { pkgs, ... }: {
    imports = [ inputs.hermes-agent.homeManagerModules.default ];

    programs.hermes-agent = {
      enable = true; # hermes CLI dans home.packages + HERMES_HOME exporté
      desktop.enable = true; # optionnel : app Desktop + entrée de menu
    };

    services.hermes-agent = {
      enable = true;
      gateway.enable = true;
      #settings.model.default = "anthropic/claude-sonnet-4";
      #environmentFiles = [ config.sops.secrets."hermes-env".path ];
      backend.mode = "dashboard"; # + the browser dashboard on 127.0.0.1:9119
      backend.port = 9119;
    };
  };
}
