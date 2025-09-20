# [Damathryxx64](https://github.com/arcanumx64/damathryxx64)

A comprehensive NixOS-WSL configuration flake that defines my personal computing environment using the Nix ecosystem. The configuration encompasses system-level settings, development shells, and dotfiles, all managed through a declarative approach that ensures reproducibility and consistency across multiple machines.

## [NixOS-WSL](https://nix-community.github.io/NixOS-WSL/)

```sh
nix-shell -p git vim curl pciutils gh
cd /tmp; export REPO="damathryxx64"; gh repo clone arcanumx64/$REPO; cd $REPO
sudo nixos-rebuild switch --flake ".#nixos"
```

## Nix development shells

```sh
# install nix - before developing python/devops developer environments
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

### [Python developer environments](https://github.com/arcanumx64/damathryxx64/blob/trunk/modules/shells/python.nix)

```sh
export NIXPKGS_ALLOW_UNFREE=1; nix develop "github:arcanumx64/damathryxx64#python" \
        --impure --extra-experimental-features nix-command --extra-experimental-features flakes
```

### [DevOps developer environments](https://github.com/arcanumx64/damathryxx64/blob/trunk/modules/shells/devops.nix)

```sh
export NIXPKGS_ALLOW_UNFREE=1; nix develop "github:arcanumx64/damathryxx64#devops" \
        --impure --extra-experimental-features nix-command --extra-experimental-features flakes
```
