{ pkgs, packages, ... }: {
  imports = [
    ./foot.nix
    # ./git.nix
    # ./lf.nix
    # ./ssh.nix
    ./starship.nix
    ./zoxide.nix
    ./pay-respects.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    # general
    neofetch

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

  programs.git = {
    enable = true;
    settings = {
      user = {
        name  = "shaykaden";
        email = "no@email.com";
      };
      init.defaultBranch = "main";
    };
  };
}