{userName ? "damathryxx64", ...}: {
  imports = [
    ./packages
    ./shells
  ];

  users.users.${userName} = {
    name = userName;
    isNormalUser = true;
    home = "/home/${userName}";
    description = userName;
    extraGroups = ["wheel" "input"];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
    extraConfig = ''
      ${userName} ALL=(ALL) NOPASSWD: /usr/bin/nix, /usr/bin/nix-*
    '';
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs = {
    nix-ld.enable = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
