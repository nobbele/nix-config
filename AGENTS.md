# AGENTS.md

Guidance for AI agents working in this repository.

## What this repo is

A personal NixOS flake built on [den](https://den.denful.dev) — aspect-oriented
Nix. Configuration is organised as **features (aspects)**, not per-host module
piles. Hosts and users select aspects; aspects own the config.

## How evaluation works

`flake.nix` does not use flake-parts. It runs `lib.evalModules` directly:

```nix
outputs = inputs:
  (inputs.nixpkgs.lib.evalModules {
    modules = [ (inputs.import-tree ./modules) ];
    specialArgs = { inherit inputs; };
  }).config.flake;
```

Consequences you must respect:

- **`import-tree` auto-imports every `.nix` file under `modules/`.** Never add an
  `imports = [ ./foo.nix ]` for a sibling module — just create the file. Adding a
  file is the whole registration step.
- **You must `git add` every new file.** Flakes evaluate from the git tree, so
  untracked files are invisible to `import-tree` and to `nix eval` /
  `nixos-rebuild`. A new module that "does nothing" is almost always an
  unstaged file. `git add -N <file>` is enough to make it visible while you
  iterate; `git status` should be clean of `??` entries before you claim a
  change works.
- Because of that, **every file under `modules/` must be a valid standalone
  module**. A file that only makes sense when imported by another file will break
  evaluation. Shared helpers belong in a `let` inside the file that uses them, or
  in a non-`.nix` data file (e.g. `starship.toml`).
- `inputs` is available everywhere via `specialArgs`, so `{ inputs, ... }:` works
  in any module without threading it through.
- `den.flakeModule` is imported once, in `modules/den.nix`. Don't import it again.

## Layout

```
modules/
  den.nix                  # imports den.flakeModule — the only "wiring" file
  defaults/                # den.default.* — applies to EVERY host/user
  hosts/                   # den.hosts declarations + per-host aspects
  terminal/                # shell / prompt / motd aspects
  *.nix                    # feature aspects (gaming, desktop, etc.)
```

`modules/defaults/` is the highest-blast-radius directory in the repo. Anything
placed there lands on every host. Before adding to it, ask whether the setting is
genuinely universal or belongs in an aspect that hosts opt into.

## Den conventions used here

- **Aspects** are `den.aspects.<name>` with per-class keys (`nixos`,
  `homeManager`, …), plus `includes` and `provides`.
- **`includes`** composes aspects. Prefer it over duplicating config.
- **`provides.<entity>`** routes config across the host/user boundary. A host
  aspect can provide to a user, and a user aspect can provide to a host.
- **`den.default.includes`** (see `modules/defaults/misc.nix`) is the global
  include list — batteries like `define-user` and `hostname` live there.
- **`den.schema.user.classes`** defaults users to `homeManager`; a user only needs
  an explicit `classes` list if it deviates.
- **Hosts declare what they want.** When adding a feature to a machine, add it to
  that host's `includes` in `modules/hosts/<host>.nix`. Do not reach into a user
  aspect and add a `provides.<host>` block — that inverts ownership and makes
  adding a host require editing user files.
- **Batteries over hand-rolling.** Check `den.batteries.*` before writing a
  module for shells, user accounts, hostnames, autologin, etc.

## Style

- 2-space indent, `nixfmt-rfc-style` compatible. Some older files use 4-space;
  match the surrounding file rather than reformatting unrelated lines.
- One aspect per file, named after the file (`modules/terminal/zsh.nix` →
  `den.aspects.zsh`).
- Keep `let` bindings at the top of the module function, not inline.
- Comment out disabled config with a short reason rather than deleting it, when
  it documents a deliberate choice.

## Verifying changes

Always evaluate before claiming a change works:

```sh
git add -N modules/            # untracked files are invisible to flakes
nix eval .#nixosConfigurations.<host>.config.<option>   # spot-check a value
nixos-rebuild build --flake .#<host>                    # full build, no switch
nix flake check                                         # eval all outputs
```

Useful checks when moving config between `defaults/` and an aspect — confirm the
option is *absent* on hosts that shouldn't have it, not just present on the ones
that should:

```sh
nix eval .#nixosConfigurations.<host>.config.services.xserver.enable
```

## Gotchas

- **`_hardware.nix` files are vendored from `nixos-generate-config`** and have
  been hand-edited (subvolumes, LUKS). Their "do not modify" header is stale.
  Keep edits minimal and hardware-only; don't put policy there.
- **Instantiating a second nixpkgs** (`import inputs.nixpkgs-unstable { ... }`)
  inside a module creates a parallel package set that home-manager can't see.
  Prefer an overlay exposing `pkgs.unstable` so both NixOS and HM can use it.
- **`den.default.nixos` runs on every host.** Desktop-environment config there
  leaks onto headless/laptop hosts.
- **`home.file` symlinks are created during `linkGeneration`.** Activation
  scripts that must run before a symlink is created need
  `entryBefore [ "linkGeneration" ]`, not `entryAfter [ "writeBoundary" ]`.

## Do not

- Add `imports` for files already covered by `import-tree`.
- Leave a new module untracked and then debug why it has no effect — `git add` it
  first.
- Put host-specific packages or services in `modules/defaults/`.
- Duplicate a package or service across host files — extract an aspect.
- Run `nixos-rebuild switch` to test a change. Build first.

## Deliberate choices — do not "fix" these

These look like mistakes but are intentional. Leave them alone unless asked:

- **`grep` is aliased to `rg`** in `modules/terminal/shell-replacements.nix`.
  This does break `-r`, `-E`, and some GNU semantics. It is wanted anyway.
- **`hyfetch` runs on every interactive shell** (`modules/terminal/motd.nix`).
  Not guarded to login shells — the banner on every new terminal is the point.
