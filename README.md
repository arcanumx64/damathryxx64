# NixOS

```sh
nix-shell -p git vim curl pciutils gh
cd /tmp; export REPO="damathryxx64"; gh repo clone arcanumx64/$REPO; cd $REPO
nixos-generate-config --show-hardware-config > modules/hardware/hardware-configuration.nix
sudo nixos-rebuild switch --flake .#nixos
```

# Nix-Shell

```sh
# python dev
nix develop .#python
# java dev
nix develop .#java
# aws dev
nix develop .#aws
```
