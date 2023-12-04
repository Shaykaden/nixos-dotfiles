{ pkgs, packages, ... }: {
  imports = [
    ./foot.nix
    ./git.nix
    ./lf.nix
    ./ssh.nix
    ./starship.nix
    ./zoxide.nix
    ./thefuck.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    # general
    neofetch
    distrobox

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep 
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    eza 
    fzf 
    skim
    bat
    tealdeer
    duf
    fd

    xdg-utils # TODO: maybe des configs  ?
    fzf # TODO: config


    appimage-run

    enhanced-ctorrent

    htop
    hyprshade
    wl-clipboard
    hyprpicker
    # blobdrop

  ];
}
