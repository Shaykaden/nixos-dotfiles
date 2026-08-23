{ self, ... }: {
	flake.homeModules.phosConfiguration.imports = [
		self.homeModules.git
	];


	flake.homeModules.git = { pkgs, lib, ... }: {
		programs.git = {
			enable = true;
			settings = {
				user = {
					name  = "Shaykaden";
					email = "none@none.com";
				};
				init.defaultBranch = "main";
			};
		};
	};
}
