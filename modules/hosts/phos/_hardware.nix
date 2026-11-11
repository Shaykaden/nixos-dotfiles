# Matériel de l'hôte phos : GPU amdgpu, kernel cachyos, swap compressé.
{ pkgs, ... }: {
  # use cachyos kernel
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  zramSwap.enable = true; # To run local IA without problem with RAM  # Test if useful or not
}
