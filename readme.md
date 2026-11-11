# nixos-dotfiles

Configuration NixOS personnelle en pattern **dendritic** : `flake-parts` produit les sorties et
`import-tree` importe automatiquement tout fichier `.nix` sous `modules/`, sans liste d'imports à
maintenir. Home-manager est branché comme module NixOS. Un seul hôte : `phos` (hostname `nixos`,
`stateVersion` 26.05), sur `nixpkgs` `nixos-unstable`, avec niri et noctalia.

## Structure

```
.
├── flake.nix
├── flake.lock
└── modules/
    ├── parts.nix
    ├── treefmt.nix
    ├── features/
    │   ├── ai/
    │   ├── applications/
    │   ├── cli/
    │   ├── desktop/
    │   ├── dev/
    │   ├── gaming/
    │   └── system/
    ├── profiles/
    │   ├── base.nix
    │   └── workstation.nix
    └── hosts/
        └── phos/
            ├── default.nix
            ├── configuration.nix
            ├── _hardware.nix
            ├── _niri-home.nix
            └── hardware-configuration.nix
```

## Commandes

```sh
nh os -q switch . -H phos
```
