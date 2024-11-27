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

          "${modifier}+Shift+o" = "move right";
          "${modifier}+Shift+y" = "move left";
          "${modifier}+Shift+e" = "move up";
          "${modifier}+Shift+n" = "move down";

          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+a" = "workspace 0:a";
          "${modifier}+s" = "workspace 1:s";
          "${modifier}+h" = "workspace 2:h";
          "${modifier}+t" = "workspace 3:t";
          "${modifier}+g" = "workspace 4:g";
          "${modifier}+y" = "workspace 5:y";
          "${modifier}+n" = "workspace 6:n";
          "${modifier}+e" = "workspace 7:e";
          "${modifier}+o" = "workspace 8:o";
          "${modifier}+i" = "workspace 9:i";

          "${modifier}+Super_R+a" = "move container to workspace 0:a";
          "${modifier}+Super_R+s" = "move container to workspace 1:s";
          "${modifier}+Super_R+h" = "move container to workspace 2:h";
          "${modifier}+Super_R+t" = "move container to workspace 3:t";
          "${modifier}+Super_R+g" = "move container to workspace 4:g";
          "${modifier}+Super_R+y" = "move container to workspace 5:y";
          "${modifier}+Super_R+n" = "move container to workspace 6:n";
          "${modifier}+Super_R+e" = "move container to workspace 7:e";
          "${modifier}+Super_R+o" = "move container to workspace 8:o";
          "${modifier}+Super_R+i" = "move container to workspace 9:i";

          # needs to be added on inverse order otherwise is order-dependent
          "${modifier}+Super_L+a" = "move container to workspace 0:a";
          "${modifier}+Super_L+s" = "move container to workspace 1:s";
          "${modifier}+Super_L+h" = "move container to workspace 2:h";
          "${modifier}+Super_L+t" = "move container to workspace 3:t";
          "${modifier}+Super_L+g" = "move container to workspace 4:g";
          "${modifier}+Super_L+y" = "move container to workspace 5:y";
          "${modifier}+Super_L+n" = "move container to workspace 6:n";
          "${modifier}+Super_L+e" = "move container to workspace 7:e";
          "${modifier}+Super_L+o" = "move container to workspace 8:o";
          "${modifier}+Super_L+i" = "move container to workspace 9:i";

          "${modifier}+u" = "workspace prev";
          "${modifier}+p" = "workspace next";
          "${modifier}+k" = "workspace back_and_forth";
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
