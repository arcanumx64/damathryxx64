{
  userName,
  pkgs,
  ...
}: {
  imports = [
    (import ./gnome.nix {
      inherit pkgs userName;
    })
  ];
}
