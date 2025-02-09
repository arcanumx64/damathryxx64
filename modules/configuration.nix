{
  config,
  pkgs,
  ...
}: {
  imports = [./desktop ./hardware ./packages ./shells];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [22];
      enable = true;
    };
  };

  time.timeZone = "Asia/Kolkata";
  i18n = {
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.damathryxx64 = {
    isNormalUser = true;
    description = "damathryx_x64";
    extraGroups = ["networkmanager" "wheel" "video" "input"];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
    extraConfig = ''
      damathryxx64 ALL=(ALL) NOPASSWD: /usr/bin/nix, /usr/bin/nix-*
    '';
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  services = {
    printing.enable = true;
    openssh.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  system.stateVersion = "24.05";
}
