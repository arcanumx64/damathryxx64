{userName ? "damathryxx64", ...}: {
  imports = [
    ./packages
    ./shells
  ];

  # Enable needed services for VS Code Remote Development
  services.openssh.enable = true;
  networking = {
    firewall.enable = true;
  };

  users.users.${userName} = {
    isNormalUser = true;
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
