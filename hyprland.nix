# /etc/nixos/hyprland.nix
{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    systemPackages = with pkgs; [
      waybar
      swaylock-effects
      swayidle
      wofi
      kitty
      #polkit_kde_agent
      networkmanagerapplet    # Network management
      pavucontrol            # Audio control
      blueman                # Bluetooth management
      brightnessctl          # Brightness control
    ];
  };

  # Enable necessary services
  services = {
    blueman.enable = true;     # Bluetooth support
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    ubuntu_font_family
  ];

  # Create the configuration files
  system.userActivationScripts = {
    setupHyprland = {
      text = ''
        mkdir -p ~/.config/{hypr,waybar,swaylock}
        cat > ~/.config/hypr/hyprland.conf << 'EOL'
monitor=,preferred,auto,1

env = XCURSOR_SIZE,24
env = GTK_THEME,Adwaita
env = QT_QPA_PLATFORMTHEME,qt5ct

# Startup
exec-once = waybar
exec-once = nm-applet --indicator    # Network
exec-once = blueman-applet           # Bluetooth
exec-once = swayidle -w timeout 300 'swaylock' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'

input {
    kb_layout = us
    follow_mouse = 1
    sensitivity = 0
    accel_profile = flat
    touchpad {
        natural_scroll = true
        tap-to-click = true
    }
}

general {
    gaps_in = 0
    gaps_out = 0
    border_size = 1
    col.active_border = rgba(000000ee)
    col.inactive_border = rgba(000000aa)
    layout = dwindle
}

animations {
    enabled = false
}

dwindle {
    pseudotile = true
    preserve_split = true
}

# Window rules for system controls
windowrule = float, ^(pavucontrol)$
windowrule = float, ^(blueman-manager)$
windowrule = float, ^(nm-connection-editor)$

# Basic keybinds
bind = SUPER, Q, exec, kitty
bind = SUPER, C, killactive,
bind = SUPER SHIFT, Q, exit,
bind = SUPER, E, exec, dolphin
bind = SUPER, V, togglefloating,
bind = SUPER, R, exec, wofi --show drun
bind = SUPER, P, pseudo,
bind = SUPER, F, fullscreen
bind = SUPER, J, togglesplit

# System control bindings
bind = SUPER, B, exec, blueman-manager     # Bluetooth settings
bind = SUPER, N, exec, nm-connection-editor # Network settings
bind = SUPER, A, exec, pavucontrol         # Audio settings

# Focus with arrow keys
bind = SUPER, left, movefocus, l
bind = SUPER, right, movefocus, r
bind = SUPER, up, movefocus, u
bind = SUPER, down, movefocus, d

# Workspaces
bind = SUPER, 1, workspace, 1
bind = SUPER, 2, workspace, 2
bind = SUPER, 3, workspace, 3
bind = SUPER, 4, workspace, 4
bind = SUPER, 5, workspace, 5
bind = SUPER, 6, workspace, 6

bind = SUPER SHIFT, 1, movetoworkspace, 1
bind = SUPER SHIFT, 2, movetoworkspace, 2
bind = SUPER SHIFT, 3, movetoworkspace, 3
bind = SUPER SHIFT, 4, movetoworkspace, 4
bind = SUPER SHIFT, 5, movetoworkspace, 5
bind = SUPER SHIFT, 6, movetoworkspace, 6

bind = SUPER ALT, L, exec, swaylock
EOL

        cat > ~/.config/waybar/config << 'EOL'
{
    "layer": "top",
    "position": "top",
    "height": 30,
    "spacing": 0,
    "modules-left": ["hyprland/workspaces"],
    "modules-center": ["clock"],
    "modules-right": ["bluetooth", "network", "pulseaudio", "battery", "tray"],

    "hyprland/workspaces": {
        "format": "{name}",
        "on-click": "activate",
        "all-outputs": true
    },

    "clock": {
        "format": "{:%I:%M %p}",
        "format-alt": "{:%Y-%m-%d}",
        "tooltip": true
    },

    "bluetooth": {
        "format": "BT",
        "format-disabled": "BT OFF",
        "format-connected": "BT {num_connections}",
        "tooltip-format": "{controller_alias}\t{controller_address}",
        "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{device_enumerate}",
        "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
        "on-click": "blueman-manager"
    },

    "network": {
        "format": "NET",
        "format-wifi": "WIFI",
        "format-ethernet": "ETH",
        "format-disconnected": "NET OFF",
        "tooltip-format": "{ifname} via {gwaddr}",
        "tooltip-format-wifi": "{essid} ({signalStrength}%)",
        "on-click": "nm-connection-editor"
    },

    "pulseaudio": {
        "format": "VOL {volume}%",
        "format-muted": "MUTED",
        "on-click": "pavucontrol"
    },

    "battery": {
        "format": "BAT {capacity}%",
        "format-charging": "CHG {capacity}%",
        "format-critical": "BAT {capacity}%",
        "states": {
            "critical": 15
        }
    },

    "tray": {
        "spacing": 10
    }
}
EOL

        cat > ~/.config/waybar/style.css << 'EOL'
* {
    border: none;
    border-radius: 0;
    font-family: "JetBrains Mono", monospace;
    font-size: 13px;
    min-height: 0;
    margin: 0;
    padding: 0;
}

window#waybar {
    background: #ffffff;
    color: #000000;
}

#workspaces button {
    padding: 0 5px;
    color: #000000;
}

#workspaces button.active {
    background: #eeeeee;
}

#clock,
#battery,
#cpu,
#memory,
#network,
#pulseaudio,
#bluetooth,
#tray {
    padding: 0 10px;
}
EOL

        cat > ~/.config/swaylock/config << 'EOL'
ignore-empty-password
font=Ubuntu

clock
timestr=%R
datestr=%a, %e of %B

color=000000
indicator-idle-visible
indicator-radius=100
indicator-thickness=7
inside-color=00000000
ring-color=000000
line-color=00000000
key-hl-color=ffffff
separator-color=00000000
text-color=ffffff
text-clear-color=ffffff
text-ver-color=ffffff
text-wrong-color=ffffff
EOL
      '';
    };
  };
}