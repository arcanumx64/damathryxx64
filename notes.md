## Nix commands

```sh
nix config show | grep experimental-features
```

```sh
nix flake show "github:arcanumx64/damathryxx64"
```

```sh
sudo nixos-rebuild switch --flake "github:arcanumx64/damathryxx64#nixos"
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

```sh
# java dev env
nix develop .#java
```

```sh
# python dev env
nix develop .#python
```

```sh
# aws dev env
nix develop .#aws
```
