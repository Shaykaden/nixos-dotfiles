{ config, pkgs, inputs, outputs, ... }: {

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
  # Modmap for single key rebinds
  services.xremap.config.modmap = [
    {
      name = "Global";
      remap = { "CapsLock" = "KEY_LEFTMETA"; }; # globally remap CapsLock to Esc
    }
  ];

  # Keymap for key combo rebinds
  services.xremap.config.keymap = [
    {
      name = "Example ctrl-u > pageup rebind";
      remap = { "C-u" = "PAGEUP"; };
    }
  ];
}

