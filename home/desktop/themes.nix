{ pkgs, ... } :

{
  # TODO: add alias
  # To check available name 
  # cd $(nix build nixpkgs#<pkgs.?> --print-out-paths --no-link)
  # nix run nixpkgs#eza -- --tree --level 4
  gtk.enable = true;
  gtk.theme.package = pkgs.orchis-theme;
  gtk.theme.name = "Orchis-Purple-Dark-Compact";

  gtk.cursorTheme.package = pkgs.bibata-cursors;
  gtk.cursorTheme.name = "Bibata-Mordern-Ice";

  gtk.iconTheme.package = pkgs.fluent-icon-theme;
  gtk.iconTheme.name = "Fluent-dark";

  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";
  qt.style.package = pkgs.adwaita-qt;
}
