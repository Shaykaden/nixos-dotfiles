# dotfiles — NixOS déclaratif (flake-parts + import-tree)

Flake NixOS mono-hôte (`nixosConfigurations.phos`) piloté par `flake-parts` et `import-tree` : **tout fichier `.nix` sous `modules/` est importé automatiquement** comme module flake-parts. `flake.nix` ne contient que les inputs, `modules/parts.nix` les réglages du flake (systems, flakeModule home-manager).

Hôte `phos` (utilisateur `phos`, home `/home/phos`, hostname `nixos`, `stateVersion` `26.05`), nixpkgs `nixos-unstable`, home-manager intégré comme module NixOS. Un seul utilisateur home-manager, couplé à l'hôte (pas de couche `users/`/`homes/` séparée : choix assumé).

## Deux axes, à ne pas mélanger

- **`modules/features/<catégorie>/`** — *quoi* : une catégorie = un domaine technique (`cli`, `system`, `desktop`, `applications`, `dev`, `gaming`, `ai`). Un fichier = une feature, qui déclare `flake.nixosModules.<nom>` et/ou `flake.homeModules.<nom>`. Le `default.nix` de la catégorie agrège ses features et expose `flake.<class>Modules.<catégorie>`.
- **`modules/profiles/`** — *pour quelle machine* : `base` (socle headless : `cli` + `system`, réutilisable pour un serveur/NAS) et `workstation` (`base` + `desktop` + `applications` + `dev` + `gaming` + `ai`). L'hôte n'importe **qu'un profil**.

Une feature n'est jamais importée directement par un profil ni par l'hôte : elle passe par le `default.nix` de sa catégorie.

## Anatomie

```
flake.nix                 inputs uniquement (sortie = import-tree ./modules)
modules/
  parts.nix               systems + flakeModule home-manager
  treefmt.nix             nixfmt + check `checks.<system>.treefmt`
  features/
    <cat>/default.nix     agrégat de la catégorie (nixosModules.<cat> / homeModules.<cat>)
    <cat>/<feature>.nix   une feature : flake.nixosModules.<feature> / flake.homeModules.<feature>
  profiles/<classe>.nix   bundle de catégories, imports uniquement
  hosts/phos/
    default.nix           `nixosConfigurations.phos` = phosConfiguration + modules des inputs
    configuration.nix     identité de la machine : hostName, stateVersion, imports, binding home-manager
    _hardware.nix         spécificités matérielles (amdgpu, kernel cachyos, zram) — module NixOS simple
    _niri-home.nix        réglages d'écran de l'hôte (DP-1) — module home-manager simple
    hardware-configuration.nix  généré par nixos-generate-config, ne pas éditer
```

## Commandes

Vérifier que le flake évalue (le seul « test » local) — sur l'arbre de travail, donc en voyant les fichiers non suivis :

```sh
nix eval --raw "path:$PWD#nixosConfigurations.phos.config.system.build.toplevel.drvPath"
```

Formatage (réécrit le dépôt) et son check :

```sh
nix fmt
nix build --no-link "path:$PWD#checks.x86_64-linux.treefmt"
```

Appliquer (effet de bord : uniquement si l'utilisateur le demande, nécessite sudo) :

```sh
nh os switch      # système complet ; programs.nh.flake = /home/phos/dotfiles
nh home switch    # home-manager seul
nix flake update  # mise à jour des inputs
```

## Conventions

- **Un fichier de feature = un nom de sortie**, unique dans `flake.nixosModules` **et** `flake.homeModules`. Ces deux espaces sont plats : deux fichiers qui déclarent le même nom fusionnent **silencieusement** (ancien bug : `homeModules.base` défini à la fois par `applications/base.nix` et `cli/base.nix`, qui dupliquait `localsend` dans `home.packages`).
- **Une catégorie n'importe que les fichiers de son propre dossier.** Une feature de `system/` importée par `desktop/default.nix` est une incohérence : déplacer le fichier.
- **Chaque feature est importée par le `default.nix` de son dossier** — sinon c'est du code mort.
- **Un profil ne contient que des imports** (au plus des `lib.mkDefault`). Jamais de `home.packages` ni de configuration concrète : sinon on ne sait plus qui a posé une valeur.
- Noms : une catégorie et un profil ne se recouvrent pas ; pas de suffixe `-profile` (le dossier porte déjà le rôle) ; jamais de nom d'hôte dans `profiles/`.
- **Ajouter une feature** : `features/<cat>/<nom>.nix` avec `flake.<class>Modules.<nom>`, puis l'ajouter au `default.nix` de sa catégorie.
- **Ajouter une catégorie** : `features/<cat>/default.nix`, puis l'ajouter au(x) profil(s) concerné(s).
- **Ajouter une machine** : `hosts/<h>/` (configuration + `_hardware.nix`), une entrée `nixosConfigurations.<h>` sur le modèle de `hosts/phos/default.nix`, et un profil si aucune classe existante ne convient. `system` et `cli` sont déjà réutilisables pour un serveur/NAS.
- Paquets : `home.packages = with pkgs; [ ... ]` dans le module home, `environment.systemPackages` seulement dans une catégorie ou `configuration.nix` pour le strict minimum système.
- Commentaires en français ; `TODO :`/`FIXME :` en fin de ligne pour les points ouverts.
- Commits : Conventional Commits **en anglais**, une ligne, **scope obligatoire** — `refactor(profiles): …`, `feat(checks): …`, `fix(desktop): …`. **Ne jamais committer à la place de l'utilisateur.**
- Jamais d'installation impérative (`nix profile add`, `nix-env -i`) : tout passe par les modules ; pour tester un paquet, `nix run`/`nix build` sans `-o`.

## Pièges

- **`import-tree` importe *tous* les `.nix` de `modules/`** : une erreur de syntaxe n'importe où casse l'évaluation du flake entier, et un fichier qui n'est pas un module flake-parts la casse aussi. Un fichier destiné à être importé par chemin (module NixOS/home « nu ») doit commencer par `_` (`_hardware.nix`, `_niri-home.nix`), sinon il est pris pour un module flake-parts.
- **L'arbre git masque les fichiers non suivis.** `nix eval .#…`, `nix build .#checks…` et `nix flake show` sur un flake `git+file://` ne voient que les fichiers suivis : un fichier nouvellement créé est invisible, et une erreur de nom de module se manifeste par `attribute 'x' missing`. Pendant un refactor, valider avec `path:$PWD#…` (qui voit tout) ; pour comparer à l'état commité, utiliser `git+file:///home/phos/dotfiles?ref=refs/heads/main#…`.
- **Deux `drvPath` différents ne prouvent pas une régression** : l'ordre de `home.packages` change le hash à comportement identique. Comparer les ensembles via `nix eval --json … --apply 'ps: builtins.sort builtins.lessThan (map (p: p.name) ps)'` sur `home.packages`, `environment.systemPackages`, `systemd.services`, `environment.etc`, `boot.kernelModules`.
- **`phosConfiguration` doit rester minimal** : quatre imports côté nixos (`home-manager`, `phosHardware`, le profil, `_hardware.nix`), deux côté home (le profil, `_niri-home.nix`). Toute feature ajoutée là échappe au profil et à la réutilisation.
- `modules/features/ai/secrets/hermes.yaml` est chiffré SOPS (age, clé `~/.config/sops/age/keys.txt`), consommé par `services.hermes-agent.environmentFiles`. Ne jamais y écrire en clair ; passer par `sops`.
- `modules/hosts/phos/hardware-configuration.nix` est généré par `nixos-generate-config` — ne pas l'éditer à la main.
- `secretspec.toml` est un gabarit vide (aucun secret réel) ; `readme.md` est un stub (« installation : »). Ne pas s'appuyer dessus comme documentation.
- Les alias zsh `rebuild`/`hrebuild`/`update` (`features/cli/zsh.nix`) délèguent à `nh os switch` / `nh home switch` / `nix flake update` sur `/home/phos/dotfiles`.
- `devenv/vs/` est un projet Python/uv indépendant (vapoursynth, package `boshi`), non importé par le flake ; `devenv/` n'est pas un output du dépôt.
- `modules/parts.nix` déclare quatre `systems` (`x86_64-linux`, `aarch64-linux`, `x86_64-darwin`, `aarch64-darwin`) alors que seul `x86_64-linux` est utilisé : le check treefmt est exposé pour les quatre.
- Beaucoup de réglages codent l'identité en dur (`phos`, `/home/phos`, hostname `nixos`, `Europe/Paris`, sortie écran `DP-1`, port `9119` du dashboard hermes) : un renommage touche plusieurs fichiers.
