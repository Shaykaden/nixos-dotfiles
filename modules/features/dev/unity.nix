{ self, ... }: {
  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.unity
  ];

  flake.nixosModules.unity = { pkgs, ... }: {
    services.flatpak.packages = [
      {
        appId = "com.unity.UnityHub";
        origin = "flathub";
      }
    ];
  };
}
