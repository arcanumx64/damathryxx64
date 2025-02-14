{
  pkgs,
  lib,
  ...
}: {
  fonts.fontconfig.enable = true;
  services = {
    printing.enable = true;
    openssh.enable = true;
    power-profiles-daemon.enable = true;
    upower.enable = true;
    accounts-daemon.enable = true;
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];

      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
        autoLogin = {
          enable = true;
          user = "damathryxx64";
        };
        setupCommands = ''
          ${pkgs.xorg.xrandr}/bin/xrandr --auto
        '';
      };

      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['scale-monitor-framebuffer']
        '';
      };
    };
    gnome = {
      evolution-data-server.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
  };

  programs.dconf.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.system-monitor
    gnomeExtensions.user-themes
    gnome-shell-extensions
  ];
}
