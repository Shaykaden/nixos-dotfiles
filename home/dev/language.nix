{ pkgs, ... }: {

  home.packages = with pkgs; [
    # Rust
    rustc
    cargo
  ];
}
