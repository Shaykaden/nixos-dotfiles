{ self, inputs, ...}: {

	flake.homeModules.phosConfiguration.imports = [
	  self.homeModules.noctalia
	];

	flake.homeModules.noctalia = { ... }: {

		imports = [ inputs.noctalia.homeModules.default ];

		programs.noctalia = {
			enable = true;
		        #settings = builtins.fromJSON (builtins.readFile ./noctalia.json);
		};
	};
}
