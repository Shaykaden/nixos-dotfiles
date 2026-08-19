{ config, pkgs, inputs, outputs, ...  }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # TODO : see nix-gaming on github
    # lowLatency = {
    #   # enable this module
    #   enable = true;
    #   # defaults (no need to be set unless modified)
    #   quantum = 64;
    #   rate = 48000;
    # };
  };

  # make pipewire realtime-capable
  security.rtkit.enable = true;
}
