{ pkgs, lib, config, ... }:

{
   programs.zsh = {
      enable = true;

      autosuggestion.enable = true;
      enableCompletion = true;

      shellAliases = {
         "update" = "cd $HOME/nix; nix flake update; cd -";
         "rebuild" = "sudo nixos-rebuild switch --flake $HOME/nix#mizuho";
         "hrebuild" = "home-manager switch --flake $HOME/nix#mizuho";
         "nix-run" = "nix run nixpkgs#";
         "nix-shell" = "nix-shell --command zsh -p";
         "nix shell" = "nix shell --command zsh";
         "ndev" = "nix develop --command zsh;";
         "py-source" = "";

         "ls" = "eza --icons --sort=type --tree --level=1 --icons --sort=type";
         "l" = "eza --icons --sort=type -G";
         "ll" = "eza --icons --sort=type -alh";
         "tree" = "eza --icons --sort=type --tree";


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

      # initExtra = mkIf cfg.enableZshIntegration ''
      #    eval "$(${cfg.package}/bin/zoxide init zsh ${cfgOptions})"
      #    '';
   };
}