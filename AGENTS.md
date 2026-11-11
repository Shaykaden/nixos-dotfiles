# dotfiles — NixOS déclaratif (flake-parts + home-manager)

Flake NixOS mono-hôte (`nixosConfigurations.phos`) piloté par `flake-parts` et `import-tree` : **tout fichier `.nix` sous `modules/` est importé automatiquement**, il n'y a aucune liste d'imports à maintenir dans `flake.nix` (qui ne contient que les inputs). Les modules déclarent eux-mêmes leurs sorties (`flake.nixosModules.X`, `flake.homeModules.X`) et s'enregistrent dans la configuration via `flake.<kind>Modules.phosConfiguration.imports`. L'hôte est `phos` (utilisateur `phos`, home `/home/phos`, hostname `nixos`, `stateVersion` `26.05`), nixpkgs `nixos-unstable`, home-manager intégré comme module NixOS.

## Commandes

Vérifier que le flake évalue (rapide, sans build — c'est le seul "test" du dépôt) :

```sh
nix eval --raw .#nixosConfigurations.phos.config.networking.hostName   # -> nixos
nix flake show                                                          # liste nixosConfigurations/nixosModules/homeModules
```

Appliquer (effet de bord : ne le lancer que si l'utilisateur le demande, nécessite sudo) :

```sh
nh os switch      # système complet ; programs.nh.flake = /home/phos/dotfiles
nh home switch    # home-manager seul
nix flake update  # mise à jour des inputs
```

Aucun CI, aucun formateur/linter au niveau du dépôt : la validation se fait par évaluation. Le formatage Nix se fait côté éditeur (Zed, `format_on_save`).

## Anatomie du dépôt

- `flake.nix` — inputs uniquement (`nix-flatpak`, `niri`, `xremap`, `noctalia`, `zen-browser`, `nixcord`, `chaotic`, `sops-nix`, `hermes-agent`, `comfyui-nix`, …), sortie = `inputs.import-tree ./modules`.
- `modules/parts.nix` — import du flakeModule home-manager + liste `systems`.
- `modules/hosts/phos/default.nix` — construit `nixosConfigurations.phos` à partir de `nixosModules.phosConfiguration` + modules des inputs (chaotic, nix-flatpak, sops-nix, nix-index-database).
- `modules/hosts/phos/configuration.nix` — config système minimale (bootloader, GC, réseau, utilisateur, `programs.zsh`) **et** le home-manager de base (`flake.homeModules.phosConfiguration`).
- `modules/features/{cli,desktop,dev,system,gaming,ai,applications}/*.nix` — un fichier = une fonctionnalité.
- `modules/system/` — fonts, correctifs système.

## Conventions

- Chaque fichier de fonctionnalité suit ce squelette :

  ```nix
  { self, inputs, ... }: {
    flake.homeModules.phosConfiguration.imports = [ self.homeModules.<nom> ];  # enregistrement
    flake.homeModules.<nom> = { pkgs, ... }: { /* ... */ };
  }
  ```

  Idem avec `flake.nixosModules.phosConfiguration` / `flake.nixosModules.<nom>` pour la partie système. Un même fichier peut porter les deux (cf. `features/desktop/niri.nix`, `features/ai/hermes.nix`) ; le nom d'attribut home et nixos peut différer (`niri` / `niriPhos`).
- Le nom du module est suffixé/dupliqué quand il y a une variante locale (`niri` = commun, `niriPhos` = réglages spécifiques hôte, importé par `phosConfiguration`).
- Paquets : `home.packages = with pkgs; [ ... ]` dans le module home, `environment.systemPackages` dans `configuration.nix` seulement pour le strict minimum système.
- Commentaires en français ; `TODO :`/`FIXME :` en fin de ligne pour les points ouverts.
- Commits : Conventional Commits en anglais, une ligne (`feat: add sops`, `fix: secrets.nix import`). Ne jamais committer à la place de l'utilisateur.
- Jamais d'installation impérative (`nix profile add`, `nix-env -i`) : tout passe par les modules ; pour tester un paquet, `nix run`/`nix build` sans `-o`.

## Pièges

- `import-tree` importe **tous** les `.nix` de `modules/` : une erreur de syntaxe dans n'importe quel fichier casse l'évaluation du flake entier, et un fichier déposé là qui n'est pas un module flake-parts (attrset de sorties) casse aussi. Rien à ajouter dans `flake.nix`, rien à retirer non plus.
- `modules/features/ai/secrets/hermes.yaml` est chiffré SOPS (age, clé `~/.config/sops/age/keys.txt`), consommé par `services.hermes-agent.environmentFiles`. Ne jamais y écrire en clair ; passer par `sops`.
- `modules/hosts/phos/hardware-configuration.nix` est généré par `nixos-generate-config` — ne pas l'éditer à la main.
- `secretspec.toml` est un gabarit vide (aucun secret réel) ; `readme.md` est un stub (« installation : »). Ne pas s'appuyer dessus comme documentation.
- Les alias zsh `rebuild`/`hrebuild`/`update` (`features/cli/zsh.nix`) pointent encore sur `$HOME/nix#mizuho`, chemin et hôte inexistants. Utiliser `nh os switch` / `nh home switch`.
- `devenv/vs/` est un projet Python/uv indépendant (vapoursynth, package `boshi`), non importé par le flake ; `devenv/` n'est pas un output du dépôt.
- Beaucoup de réglages codent l'identité en dur (`phos`, `/home/phos`, hostname `nixos`, `Europe/Paris`, sortie écran `DP-1`, port `9119` du dashboard hermes) : un renommage touche plusieurs fichiers.
