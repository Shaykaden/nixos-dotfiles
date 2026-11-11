{ inputs, ... }: {
  flake.nixosModules.hermes = {
    users.users.phos.linger = true;
  };

  flake.homeModules.hermes = { config, ... }: {
    imports = [
      inputs.hermes-agent.homeManagerModules.default
      inputs.sops-nix.homeManagerModules.sops
    ];

    programs.hermes-agent = {
      enable = true; # hermes CLI dans home.packages + HERMES_HOME exporté
      desktop.enable = true; # optionnel : app Desktop + entrée de menu
    };

    services.hermes-agent = {
      enable = true;
      gateway.enable = true;
      environmentFiles = [ config.sops.secrets."hermes-env".path ];
      backend.mode = "dashboard"; # + the browser dashboard on 127.0.0.1:9119
      backend.port = 9119;

      settings = {
        model = {
          default = "deepseek-flash";
          base_url = "https://api.deepseek.com";
        };
      };
    };

    sops = {
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      defaultSopsFile = ./secrets/hermes.yaml;
      secrets."hermes-env" = {
        format = "yaml";
      };
    };
  };
}
