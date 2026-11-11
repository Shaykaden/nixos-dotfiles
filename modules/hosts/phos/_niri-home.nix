# Sortie vidéo propre à l'hôte phos (DP-1).
{ ... }: {
  programs.niri.settings = {
    outputs."DP-1" = {
      mode = {
        width = 3440;
        height = 1440;
        refresh = 179.989;
      };

      variable-refresh-rate = "on-demand"; # screen flicker, check after driver installation + troubleshooting niri docs
    };
  };
}
