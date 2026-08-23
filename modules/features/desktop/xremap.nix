{ self, inputs, ... }: {
  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.xremap
  ];

  flake.nixosModules.xremap = { ... }: {
    imports = [
      inputs.xremap-flake.nixosModules.default
    ];

    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];

    services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", TAG+="uaccess"
    '';

    services.xremap = {
      enable = true;
      withNiri = true;
      watch = true;
    };

    services.xremap.config.modmap = [
      {
        name = "Global";
        remap = {
          "CapsLock" = "KEY_LEFTMETA";
        }; # globally remap CapsLock to super
      }
    ];
  };
}
