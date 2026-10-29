{ self, inputs, ... }: {
  flake.nixosModules.phosConfiguration.imports = [
    self.nixosModules.comfyui
  ];

  flake.nixosModules.comfyui = { ... }: {
    imports = [
      inputs.comfyui-nix.nixosModules.default
    ];

    services.comfyui = {
      enable = true;
      gpuSupport = "rocm"; # Enable AMD GPU acceleration
      enableManager = true; # Enable the built-in ComfyUI Manager
      port = 8188;
      listenAddress = "127.0.0.1"; # Use "0.0.0.0" for network access
      dataDir = "/home/nixModules/comfyui-data";
      openFirewall = false;
      # extraArgs = [ "--lowvram" ];
      # environment = { };
    };
  };
}
