{
   description = "Your new nix config";

   inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      home-manager = {
         url = "github:nix-community/home-manager/";
         inputs.nixpkgs.follows = "nixpkgs";
      };

      hyprland.url = "github:hyprwm/Hyprland";

      blobdrop.url = "github:numtide/flake-utils";
      xremap-flake.url = "github:xremap/nix-flake";
      nix-colors.url = "github:misterio77/nix-colors";
      ags.url = "github:Aylur/ags";
   };

   outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
   let
      user = "mizuho";
      lib = nixpkgs.lib // home-manager.lib;
       inherit (self) outputs;
       systems = [
         "x86_64-linux"
       ];
       # This is a function that generates an attribute by calling a function you
       # pass to it, with each system as an argument
       forAllSystems = nixpkgs.lib.genAttrs systems;

       forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
       pkgsFor = lib.genAttrs systems (system: import nixpkgs {
         inherit system;
         config.allowUnfree = true;
      });
   in {
      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays {inherit inputs;};
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;

      # NixOS configuration entrypoint
      nixosConfigurations = {
         mizuho = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs outputs;};
            modules = [
               ./nixos/mizuho.nix
            ];
         };
      };

      # Standalone home-manager configuration entrypoint
      homeConfigurations = {
         "mizuho" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
               extraSpecialArgs = {inherit inputs outputs user;};
            modules = [
               ./home/mizuho.nix

            ];
         };
      };
   };
}
