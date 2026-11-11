{ inputs, ... }: {
  flake.nixosModules.comfyui = {
    imports = [
      inputs.comfyui-nix.nixosModules.default
    ];

    services.comfyui = {
      enable = true;
      gpuSupport = "rocm"; # Enable AMD GPU acceleration
      enableManager = true; # Enable the built-in ComfyUI Manager
      port = 8188;
      listenAddress = "127.0.0.1"; # Use "0.0.0.0" for network access
      user = "phos";
      group = "users";
      dataDir = "/home/phos/nixModules/comfyui-data";
      openFirewall = false;
      extraArgs = [
        "--disable-xformers"
        "--use-pytorch-cross-attention"
      ];
    };

    # add cache
    nix.settings = {
      extra-substituters = [
        "https://cache.nixos.org"
        "https://comfyui.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "comfyui.cachix.org-1:33mf9VzoIjzVbp0zwj+fT51HG0y31ZTK3nzYZAX0rec="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
