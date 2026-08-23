{ self, inputs, ... }: {
  flake.homeModules.phosConfiguration.imports = [
	  self.homeModules.packages
	];


  flake.homeModules.packages = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
    # general
    #neofetch

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep
    #jq # A lightweight and flexible command-line JSON processor
    #yq-go # yaml processer https://github.com/mikefarah/yq
    eza
    #skim
    bat
    tealdeer
    duf
    fd

    #xdg-utils # TODO: maybe des configs  ?
    fzf # TODO: config


    #appimage-run
    nix-output-monitor

    #enhanced-ctorrent

    htop
    # blobdrop
  ];
};
}
