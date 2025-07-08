{...}: {
  nixpkgs.config.permittedInsecurePackages = [
    "libxml2-2.13.8"
  ];
}
