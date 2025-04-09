# NixOS

```sh
nix-shell -p git vim curl pciutils gh
cd /tmp; export REPO="damathryxx64"; gh repo clone arcanumx64/$REPO; cd $REPO
nixos-generate-config --show-hardware-config > modules/hardware/hardware-configuration.nix
sudo nixos-rebuild switch --flake ".#nixos"
```

# Nix-Shell

```sh
# python dev
export NIXPKGS_ALLOW_UNFREE=1; nix develop "github:arcanumx64/damathryxx64#python" \
        --impure --extra-experimental-features nix-command --extra-experimental-features flakes
# devops dev
export NIXPKGS_ALLOW_UNFREE=1; nix develop "github:arcanumx64/damathryxx64#devops" \
        --impure --extra-experimental-features nix-command --extra-experimental-features flakes
```
