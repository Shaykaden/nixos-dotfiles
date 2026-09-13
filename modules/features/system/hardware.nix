{ inputs, ... }: {
  flake.nixosModules.phosConfiguration = { pkgs, ... }: {
    # use cachyos kernel
    boot.kernelPackages = pkgs.linuxPackages_cachyos;
    boot.initrd.kernelModules = [ "amdgpu" ];

    services.xserver.enable = true;
    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
