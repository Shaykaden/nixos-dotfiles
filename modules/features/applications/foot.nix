{
  flake.homeModules.foot = {
    programs.foot = {
      enable = true;
      server.enable = true;

      settings = {
        main = {
          font = "JetBrainsMonoNerdFontMono:size=11";
          pad = "2x0";
        };

        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
