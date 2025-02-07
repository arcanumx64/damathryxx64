# NixOS
```sh
nix-shell -p git vim curl pciutils gh
gh repo clone arcanumx64/damathryxx64
nixos-generate-config --dir .
sudo nixos-rebuild switch --flake .#nixos
```
# Nix-Shell
```sh
# python dev
nix-shell .#python
# java dev
nix-shell .#java
```