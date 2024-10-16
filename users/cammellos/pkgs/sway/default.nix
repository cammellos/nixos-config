{ config, pkgs, ... }:
let
  background-image = ./background/calvin-and-hobbes.png;
  lock-image = ./background/trout.jpeg;
in
{

  home-manager.users.cammellos = {
    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 600;
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
        }
        {
          timeout = 605;
          command = "${pkgs.swaylock}/bin/swaylock -f -i ${lock-image}";
        }
        {
          timeout = 660;
          command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock";
        }
      ];
    };
    home.packages = with pkgs; [
      swaybg
      swaylock
      swayidle
      wl-clipboard
    ];
    wayland.windowManager.sway = {
      enable = true;

      config = rec {
        modifier = "Mod4";
        menu = "${pkgs.rofi-wayland}/bin/rofi -combi-modi window,drun -show combi";

        workspaceAutoBackAndForth = true;

        window = {
          border = 0;
          titlebar = false;
        };
        floating.titlebar = false;

        terminal = "${pkgs.alacritty}/bin/alacritty";
        bars = [
          {
            command = "${pkgs.waybar}/bin/waybar";
            position = "top";
            hiddenState = "hide";
            mode = "hide";
            extraConfig = ''
              modifier ${modifier}
            '';
          }
        ];

        output = {
          "eDP-1" = {
            scale = "1.3";
          };
          "DP-4" = {
            scale = "1.5";
          };
        };
        input = {
          "type:keyboard" = {
            xkb_layout = "us";
            xkb_variant = "workman";
          };
        };

        keybindings = {
          "${modifier}+Return" = "exec ${terminal}";
          "${modifier}+c" = "exec '${menu}'";

          "${modifier}+Shift+q" = "kill";

          #          "${modifier}+o" = "focus right";
          #          "${modifier}+y" = "focus left";
          #          "${modifier}+e" = "focus up";
          #          "${modifier}+n" = "focus down";

          "${modifier}+Shift+o" = "move right";
          "${modifier}+Shift+y" = "move left";
          "${modifier}+Shift+e" = "move up";
          "${modifier}+Shift+n" = "move down";

          "${modifier}+h" = "split h";
          "${modifier}+v" = "split v";

          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+0" = "workspace 0";
          "${modifier}+1" = "workspace 1";
          "${modifier}+2" = "workspace 2";
          "${modifier}+3" = "workspace 3";
          "${modifier}+4" = "workspace 4";
          "${modifier}+5" = "workspace 5";
          "${modifier}+6" = "workspace 6";
          "${modifier}+7" = "workspace 7";
          "${modifier}+8" = "workspace 8";
          "${modifier}+9" = "workspace 9";

          "${modifier}+Shift+0" = "move container to workspace 0";
          "${modifier}+Shift+1" = "move container to workspace 1";
          "${modifier}+Shift+2" = "move container to workspace 2";
          "${modifier}+Shift+3" = "move container to workspace 3";
          "${modifier}+Shift+4" = "move container to workspace 4";
          "${modifier}+Shift+5" = "move container to workspace 5";
          "${modifier}+Shift+6" = "move container to workspace 6";
          "${modifier}+Shift+7" = "move container to workspace 7";
          "${modifier}+Shift+8" = "move container to workspace 8";
          "${modifier}+Shift+9" = "move container to workspace 9";

          "${modifier}+o" = "workspace next";
          "${modifier}+y" = "workspace prev";
        };

        startup = [
          { command = "${pkgs.networkmanagerapplet}/bin/nm-applet"; }
          { command = "${pkgs.pasystray}/bin/pasystray"; }
          { command = "${pkgs.dropbox}/bin/dropbox"; }
          { command = "${pkgs.conky}/bin/conky"; }
        ];
        fonts = {
          names = [ "Inconsolata Nerd Font Mono" ];
          size = 10.0;
        };
        output."*".bg = "${background-image} fill";
      };
      extraConfig = ''
        # Watch closed laptop lid
        set $laptop eDP-1
        bindswitch --reload --locked lid:on output $laptop disable
        bindswitch --reload --locked lid:off output $laptop enable
      '';

    };

  };

  security.pam.services.swaylock = { };

}
