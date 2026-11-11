{
  flake.homeModules.osu = { pkgs, ... }: {
    home.packages = with pkgs; [
      osu-lazer-bin
    ];
  };

  flake.nixosModules.opentabletdriver = {
    hardware.opentabletdriver.enable = true;
    hardware.uinput.enable = true;
    boot.kernelModules = [ "uinput" ];
  };
}
