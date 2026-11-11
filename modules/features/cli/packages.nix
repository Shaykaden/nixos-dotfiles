{
  flake.homeModules.packages = { pkgs, ... }: {
    home.packages = with pkgs; [
      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep
      eza
      bat
      duf
      fd

      fzf # TODO: config

      nix-output-monitor

      htop
    ];
  };
}
