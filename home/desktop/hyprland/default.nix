{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    package = <inputs.hyprland> # TODO: make it here

    systemd = {
      enable = true;
      extraCommands = lib.mkBefore [
        # Make sure graphical-session is deactivated before activating hyprland-session
        "systemctl --user stop graphical-session.target"
      ];
    };
  }
}
