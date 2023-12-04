{ pkgs, inputs, ... }: 

{
  imports = [
    # ./xremap.nix
    ./themes.nix
    ./ags.nix
  ];

  home.packages = with pkgs; [
    bottles
    docker-client
    neovide
    discord
  ];
}
