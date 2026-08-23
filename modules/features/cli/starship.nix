{ self, inputs, ... }: {
  flake.homeModules.phosConfiguration.imports = [
	  self.homeModules.starship
	];


  flake.homeModules.starship = { pkgs, lib, ... }: {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.starship;

      settings = {
         format = lib.concatStrings [
            " "
            "$directory"
            "$git_branch"
            "$docker_context"
            "$character"
         ];
         right_format = lib.concatStrings [
            "$cmd_duration"
            "$nix_shell"
            "$nodejs"
            "$python"
            " "
         ];

         scan_timeout = 10;

         directory = {
            truncation_length = 5;
            truncate_to_repo = false;
            style = "bold cyan";
            before_repo_root_style = "blue";
            repo_root_style = "bold cyan";
         };

         docker_context = {
            symbol = " ";
            format = "[$symbol]($style)";
         };

         cmd_duration = {
            format = "[$duration]($style) ";
         };

         nix_shell = {
            symbol = "❄️ ";
            format = "[$symbol]($style)";
         };

         nodejs = {
            format = "─ [$symbol($version )]($style)";
         };

         python = {
            symbol = " ";
            format = "─ [$\{symbol\}$\{pyenv_prefix\}($\{version\} )(\($virtualenv\) )]($style)";
         };

         # git_branch = {
         # };

         # character = {
         #    success_symbol = "➜";
         #    error_symbol = "➜";
         # };
      };
   };
};
}
