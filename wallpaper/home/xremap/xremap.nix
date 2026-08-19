{ pkgs, inputs, ... }: {
  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  services.xremap = {
    enable = true;
    withNiri = true;
    # Modmap for single key rebinds
    config.modmap = [{
      name = "Global";
      remap = { "CapsLock" = "Esc"; };
    }];
    
    # Keymap for key combo rebinds
    config.keymap = [{
      name = "Example ctrl-u > pageup rebind";
      remap = { "C-u" = "PAGEUP"; };
    }];
  };
}
