{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zoom-us
    citrix_workspace
  ];
}
