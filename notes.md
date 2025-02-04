## Nix commands
```sh
nix config show | grep experimental-features
```
```sh
nix flake show "github:arcanumx64/damathryxx64=nix"
```
```sh
sudo nixos-rebuild switch --flake "github:arcanumx64/damathryxx64=nix#nixos"
```
```sh
sudo nix-collect-garbage -d
```
```sh
sudo nix-store --gc
```
```sh
nix-env --list-generations
```
```sh
sudo nix-env --delete-generations old
```
```sh
sudo nixos-rebuild switch --rollback
```
```sh
nix-env -q
```
```sh
nix-env -iA nixpkgs.git
```
```sh
nix-env -e git
```
```sh
nixos-rebuild dry-run --flake .
```
```sh
nix config check
```
```sh
nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

## references
- https://determinate.systems/posts/declarative-gnome-configuration-with-nixos/
- https://heywoodlh.io/nixos-gnome-settings-and-keyboard-shortcuts
- https://help.gnome.org/users/gnome-help/stable/shell-keyboard-shortcuts.html.en
- https://help.gnome.org/users/
- https://nix.dev/manual/nix/2.18/introduction
