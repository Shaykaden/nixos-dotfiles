{ self, ... }: {
  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.unity
  ];

  flake.homeModules.phosConfiguration.imports = [
    self.homeModules.unity
  ];

  flake.nixosModules.unity = { ... }: {
    services.flatpak.packages = [
      {
        appId = "com.unity.UnityHub";
        origin = "flathub";
      }
    ];

    # nix-ld to execute unity-cli
    programs.nix-ld.enable = true;
  };

  flake.homeModules.unity =
    {
      pkgs,
      lib,
      ...
    }:
    {
      home.activation.installUnityCli = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        UNITY_CLI_DIR="$HOME/.local/share/unity-cli"
        UNITY_BIN="$UNITY_CLI_DIR/bin/unity"

        if [ ! -x "$UNITY_BIN" ]; then
          echo "Installing Unity CLI..."

          export PATH="${
            lib.makeBinPath [
              pkgs.curl
              pkgs.bash
              pkgs.coreutils
              pkgs.gawk
            ]
          }:$PATH"

          curl -fsSL \
            https://public-cdn.cloud.unity3d.com/hub/prod/cli/install.sh \
            | UNITY_CLI_HOME="$UNITY_CLI_DIR" \
              UNITY_CLI_CHANNEL=beta \
              bash
        fi
      '';

      # FIXME
      # home.sessionPath doesn't work, so I add it to zsh
      programs.zsh.initContent = ''
        path=("$HOME/.local/share/unity-cli/bin" $path)
      '';
    };

}
