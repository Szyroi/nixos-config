{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Hyprland Utilities
    hyprpaper
  ];

  # Hyprland aktivieren
  wayland.windowManager.hyprland.enable = true;

  services = {
    hyprpaper = {
      enable = true;
      settings = let
        path = "~/Pictures/WP1.jpg";
      in {
        splash = false;
        ipc = true;
        preload = [
          "${path}"
        ];
        wallpaper = [
          {
            monitor = "DP-3";
            path = "${path}";
          }
          {
            monitor = "DP-2";
            path = "${path}";
          }
        ];
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    ################
    ### MONITORS ###
    ################

    monitor = [
      "DP-2, 3840x2160@144, auto-right, 1.5"
      "DP-3, 1920x1080@144, auto-left, 1"
    ];

    xwayland = {
      force_zero_scaling = true;
    };

    ###################
    ### MY PROGRAMS ###
    ###################

    "$terminal" = "kitty";
    "$fileManager" = "thunar";
    "$menu" = "wofi --show drun";
    "$browser" = "firefox";

    #################
    ### AUTOSTART ###
    #################

    exec-once = [
      "hyprpaper"
      "$browser"
      "vesktop"
      "dbus-launch --exit-with-session"
      "fcitx5 -d"
    ];
    exec = [
      "easyeffects --gapplication-service"
    ];

    #############################
    ### ENVIRONMENT VARIABLES ###
    #############################

    env = [
      "XCURSOR_SIZE,24"
      "GDK_SCALE,2"
    ];
    "env XCURSOR_THEME" = "Bibata-Modern-Classic";

    #####################
    ### LOOK AND FEEL ###
    #####################

    decoration = {
      rounding = 10;
      rounding_power = 2;
      active_opacity = 1.0;
      inactive_opacity = 1.0;
      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };

      blur = {
        enabled = true;
        size = 1;
        passes = 3;
        vibrancy = 0.17;
      };
    };

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 1;
      "col.active_border" = "rgba(245,0,0,1) rgba(245,0,0,1)";
      "col.inactive_border" = "rgba(595959aa)";
      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
    };

    animations = {
      enabled = true;
      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];

      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 1, 1.94, almostLinear, fade"
        "workspacesIn, 1, 1.21, almostLinear, fade"
        "workspacesOut, 1, 1.94, almostLinear, fade"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      new_status = "master";
    };

    misc = {
      force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
      disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
    };

    #############
    ### INPUT ###
    #############

    input = {
      kb_layout = "de";
      numlock_by_default = true;
      follow_mouse = 1;
      sensitivity = 0;
      accel_profile = "flat";
    };

    device = {
      name = "logitech-usb-receiver"; # hyprctl devices
      accel_profile = "flat";
      sensitivity = 0.3;
    };

    ###################
    ### KEYBINDINGS ###
    ###################

    "$mod" = "SUPER";

    bind =
      [
        "$mod, T, exec, $terminal"
        "$mod, E, exec, $fileManager"
        "$mod, B, exec, $browser"
        "$mod, Space, exec, $menu"
        "$mod, M, exit"
        "$mod, Q, killactive"

        # Move focus with mainMod + arrow keys
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i: let
            ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        )
        9
      ));

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindl = [
      # Requires playerctl
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];
  };

  ##############################
  ### WINDOWS AND WORKSPACES ###
  ##############################

  wayland.windowManager.hyprland.extraConfig = ''


  '';
}
