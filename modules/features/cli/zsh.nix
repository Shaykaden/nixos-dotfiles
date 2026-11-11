{
  flake.homeModules.zsh = { pkgs, ... }: {
    programs.zsh = {
      enable = true;

      autosuggestion.enable = true;
      enableCompletion = true;

      shellAliases = {
        "update" = "cd /home/phos/dotfiles && nix flake update";
        "rebuild" = "nh os switch";
        "hrebuild" = "nh home switch";
        "nix-run" = "nix run nixpkgs#";
        "nix-shell" = "nix-shell --command zsh -p";
        "nix shell" = "nix shell --command zsh";
        "ndev" = "nix develop --command zsh;";

        "ls" = "eza --icons --sort=type --tree --level=1";
        "l" = "eza --icons --sort=type -G";
        "ll" = "eza --icons --sort=type -alh";
        "tree" = "eza --icons --sort=type --tree";

        "z" = "zoxide";

        "bat" = "bat --theme base16";
        "oproject" = "cd $HOME/repos/ ; nvim $(fzf)";
        "edit" = "nvim $(fzf -e)";
      };

      plugins = [
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "master";
            sha256 = "1b4pksrc573aklk71dn2zikiymsvq19bgvamrdffpf7azpq6kxl2";
          };
        }
      ];

      initContent = ''eval "$(devenv hook zsh)"''; # Devenv autoactivation
    };
  };
}
