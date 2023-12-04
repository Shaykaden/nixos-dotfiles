# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # blobdrop = pkgs.callPackage ./blobdrop.nix { };
  # hyprslurp = pkgs.callPackage ./hyprslurp { };
  aegisube = pkgs.callPackage ./aegisub { };
  krisp-patch = pkgs.callPackage ./krips-patch { };
}
