{
  flake.nixosModules.audio = { pkgs, ... }: {
    security.rtkit.enable = true; # Enable RealtimeKit to use the realtime scheduler for increased performance

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # TODO : check other parameters like low latency : https://wiki.nixos.org/wiki/PipeWire

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}
