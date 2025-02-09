{
  config,
  pkgs,
  lib,
  ...
}: {
  fonts.fontconfig.enable = true;
  services.xserver = {
    enable = true;

    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
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

    videoDrivers = ["nvidia"];
  };

  programs.dconf.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
    accounts-daemon.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
  };

  programs.dconf.profiles.user.databases = with lib; [
    {
      settings = {
        "org/gnome/desktop/interface" = {
          accent-color = "slate";
          color-scheme = "prefer-dark";
          cursor-size = gvariant.mkInt32 24;
          enable-animations = false;
          gtk-theme = "Adwaita-dark";
          icon-theme = "Gruvbox-Dark";
          show-battery-percentage = true;
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          two-finger-scrolling-enabled = true;
        };

        "org/gnome/desktop/wm/preferences" = {
          num-workspaces = gvariant.mkInt32 4;
        };

        "org/gnome/mutter" = {
          dynamic-workspaces = false;
          edge-tiling = true;
          workspaces-only-on-primary = true;
        };

        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/map-l.svg";
          picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/map-d.svg";
          primary-color = "#241f31";
          secondary-color = "#000000";
        };

        "org/gnome/desktop/screensaver" = {
          color-shading-type = "solid";
          picture-options = "zoom";
          picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/map-l.svg";
          primary-color = "#241f31";
          secondary-color = "#000000";
        };

        "org/gnome/shell" = {
          disable-user-extensions = false;
          disabled-extensions = [
            "apps-menu@gnome-shell-extensions.gcampax.github.com"
            "places-menu@gnome-shell-extensions.gcampax.github.com"
            "window-list@gnome-shell-extensions.gcampax.github.com"
            "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
            "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
          ];
          enabled-extensions = [
            "system-monitor@gnome-shell-extensions.gcampax.github.com"
            "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
            "light-style@gnome-shell-extensions.gcampax.github.com"
            "native-window-placement@gnome-shell-extensions.gcampax.github.com"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com"
            "status-icons@gnome-shell-extensions.gcampax.github.com"
            "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
          favorite-apps = [
            "code.desktop"
            "org.gnome.Console.desktop"
            "org.gnome.TextEditor.desktop"
            "org.gnome.Settings.desktop"
            "google-chrome.desktop"
          ];
        };

        "org/gnome/desktop/input-sources" = {
          sources = [["xkb" "us"]];
          xkb-options = ["terminate:ctrl_alt_bksp"];
        };

        "org/gnome/desktop/privacy" = {
          old-files-age = gvariant.mkInt32 30;
          recent-files-max-age = gvariant.mkInt32 (- 1);
        };

        "org/gnome/desktop/session" = {
          idle-delay = gvariant.mkInt32 300;
        };

        "org/gnome/settings-daemon/plugins/power" = {
          power-button-action = "interactive";
          sleep-inactive-ac-type = "nothing";
          sleep-inactive-battery-type = "nothing";
        };

        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = false;
          night-light-schedule-automatic = false;
          night-light-temperature = gvariant.mkInt32 2700;
        };

        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };
      };
    }
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.system-monitor
    gnomeExtensions.user-themes
    gnome-shell-extensions
  ];
}
