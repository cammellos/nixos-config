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

          "${modifier}+a" = "workspace a";
          "${modifier}+s" = "workspace s";
          "${modifier}+h" = "workspace h";
          "${modifier}+t" = "workspace t";
          "${modifier}+g" = "workspace g";
          "${modifier}+y" = "workspace y";
          "${modifier}+n" = "workspace n";
          "${modifier}+e" = "workspace e";
          "${modifier}+o" = "workspace o";
          "${modifier}+i" = "workspace i";

          "${modifier}+Super_R+a" = "move container to workspace a";
          "${modifier}+Super_R+s" = "move container to workspace s";
          "${modifier}+Super_R+h" = "move container to workspace h";
          "${modifier}+Super_R+t" = "move container to workspace t";
          "${modifier}+Super_R+g" = "move container to workspace g";
          "${modifier}+Super_L+y" = "move container to workspace y";
          "${modifier}+Super_L+n" = "move container to workspace n";
          "${modifier}+Super_L+e" = "move container to workspace e";
          "${modifier}+Super_L+o" = "move container to workspace o";
          "${modifier}+Super_L+i" = "move container to workspace i";

          "${modifier}+u" = "workspace next";
          "${modifier}+p" = "workspace prev";
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
