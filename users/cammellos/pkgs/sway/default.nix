{ config, pkgs, ... }:
let
  background-image = ./background/calvin-and-hobbes.png;
  lock-image = ./background/trout.jpeg;
  browser = "librewolf";
  keepass = "org.keepassxc.KeePassXC";
  media_player = "tidal-hifi";
  terminal_command = "/home/cammellos/.local/bin/remote-kitty.sh";
  social = "ferdium";
  workspace_0 = "0:a";
  workspace_1 = "1:s";
  workspace_2 = "2:h";
  workspace_3 = "3:t";
  workspace_4 = "4:g";
  workspace_5 = "5:y";
  workspace_6 = "6:n";
  workspace_7 = "7:e";
  workspace_8 = "8:o";
  workspace_9 = "9:i";

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

        focus = {
          followMouse = "yes";
        };

        window = {
          border = 0;
          titlebar = false;
        };
        floating.titlebar = false;

        terminal = "${terminal_command}";
        bars = [
          {
            command = "${pkgs.waybar}/bin/waybar";
            position = "top";
            #hiddenState = "hide";
            #mode = "hide";
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

          "${modifier}+Shift+o" = "move right";
          "${modifier}+Shift+y" = "move left";
          "${modifier}+Shift+e" = "move up";
          "${modifier}+Shift+n" = "move down";

          "${modifier}+Period" = "fullscreen toggle";
          "${modifier}+Shift+space" = "floating toggle";
          "${modifier}+space" = "focus mode_toggle";

          "${modifier}+a" = "workspace ${workspace_0}";
          "${modifier}+s" =
            "exec swaymsg workspace ${workspace_1}; exec --no-startup-id \"pgrep ${browser} || exec ${browser}\"";
          "${modifier}+h" = "workspace ${workspace_2}";
          "${modifier}+t" = "workspace ${workspace_3}";
          "${modifier}+g" = "workspace ${workspace_4}";
          "${modifier}+y" =
            "exec swaymsg workspace ${workspace_5}; exec \"pgrep keepassxc || exec keepassxc\"";
          "${modifier}+n" = "workspace ${workspace_6}";
          "${modifier}+e" = "workspace ${workspace_7}";
          "${modifier}+o" = "workspace ${workspace_8}";
          "${modifier}+i" =
            "exec swaymsg workspace ${workspace_9}; exec \"pgrep ${media_player} || exec ${media_player}\"";

          "${modifier}+Super_R+a" = "move container to workspace ${workspace_0}";
          "${modifier}+Super_R+s" = "move container to workspace ${workspace_1}";
          "${modifier}+Super_R+h" = "move container to workspace ${workspace_2}";
          "${modifier}+Super_R+t" = "move container to workspace ${workspace_3}";
          "${modifier}+Super_R+g" = "move container to workspace ${workspace_4}";
          "${modifier}+Super_R+y" = "move container to workspace ${workspace_5}";
          "${modifier}+Super_R+n" = "move container to workspace ${workspace_6}";
          "${modifier}+Super_R+e" = "move container to workspace ${workspace_7}";
          "${modifier}+Super_R+o" = "move container to workspace ${workspace_8}";
          "${modifier}+Super_R+i" = "move container to workspace ${workspace_9}";

          # needs to be added on inverse order otherwise is order-dependent
          "${modifier}+Super_L+a" = "move container to workspace ${workspace_0}";
          "${modifier}+Super_L+s" = "move container to workspace ${workspace_1}";
          "${modifier}+Super_L+h" = "move container to workspace ${workspace_2}";
          "${modifier}+Super_L+t" = "move container to workspace ${workspace_3}";
          "${modifier}+Super_L+g" = "move container to workspace ${workspace_4}";
          "${modifier}+Super_L+y" = "move container to workspace ${workspace_5}";
          "${modifier}+Super_L+n" = "move container to workspace ${workspace_6}";
          "${modifier}+Super_L+e" = "move container to workspace ${workspace_7}";
          "${modifier}+Super_L+o" = "move container to workspace ${workspace_8}";
          "${modifier}+Super_L+i" = "move container to workspace ${workspace_9}";

          "${modifier}+d" = "exec --no-startup-id /home/cammellos/.local/bin/remote-kitty.sh d";
          "${modifier}+r" = "exec --no-startup-id /home/cammellos/.local/bin/remote-kitty.sh r";
          "${modifier}+w" = "exec --no-startup-id /home/cammellos/.local/bin/remote-kitty.sh w";
          "${modifier}+f" = "exec --no-startup-id /home/cammellos/.local/bin/remote-kitty.sh b";
          "${modifier}+u" = "exec --no-startup-id /home/cammellos/.local/bin/remote-kitty.sh j";
          "${modifier}+p" = "exec --no-startup-id /home/cammellos/.local/bin/remote-kitty.sh f";
          "${modifier}+Semicolon" =
            "exec --no-startup-id /home/cammellos/.local/bin/launch-kitty-scrollback.sh";

          "${modifier}+Super_R+q" = "kill";
          "${modifier}+Super_L+q" = "kill";

          "${modifier}+8" = "workspace prev";
          "${modifier}+9" = "workspace next";
          "${modifier}+k" = "workspace back_and_forth";

          "${modifier}+2" = "exec playerctl play-pause";
          "${modifier}+3" = "exec playerctl previous";
          "${modifier}+4" = "exec playerctl next";
        };

        startup = [
          { command = "${pkgs.networkmanagerapplet}/bin/nm-applet"; }
          { command = "${pkgs.pasystray}/bin/pasystray"; }
          { command = "${pkgs.dropbox}/bin/dropbox"; }
          { command = "${pkgs.conky}/bin/conky"; }
          { command = "XDG_CURRENT_DESKTOP=sway"; }
          { command = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all"; }
          {
            command = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP=sway";
          }
        ];
        fonts = {
          names = [ "JetBrainsMono Nerd Font Mono Bold" ];
          size = 10.0;
        };
        output."*".bg = "${background-image} fill";
      };
      extraConfig = ''
                # Watch closed laptop lid
                set $laptop eDP-1
                bindswitch --reload --locked lid:on output $laptop disable
                bindswitch --reload --locked lid:off output $laptop enable

                assign [app_id="${browser}"] workspace ${workspace_1}
                assign [class="steam"] workspace ${workspace_4}
                assign [app_id="${keepass}"] workspace ${workspace_5}
                assign [app_id="${media_player}"] workspace ${workspace_9}

                # Start with specific app_id/class
                set $ddterm-id dropdown-terminal
                set $ddterm kitty --class $ddterm-id
                set $ddterm-resize resize set 100ppt 40ppt, move position 0 0

                # resize/move new dropdown terminal windows
                for_window [app_id="$ddterm-id"] {
                  floating enable
                  $ddterm-resize
                  move to scratchpad
                  scratchpad show
                }

                # show existing or start new dropdown terminal
                bindsym Mod4+j exec swaymsg '[app_id="$ddterm-id"] scratchpad show' \
                  || $ddterm \
                  && sleep .1 && swaymsg '[app_id="$ddterm-id"] $ddterm-resize'

                # Start with specific app_id/class
                set $social-id ${social}
                set $social ${social} --class $social-id
                set $social-resize resize set 100ppt 90ppt, move position 0 0

                # resize/move new dropdown terminal windows
                for_window [app_id="$social-id"] {
                  floating enable
                  $social-resize
                  move to scratchpad
                  scratchpad show
                }

                # show existing or start new dropdown terminal
                bindsym Mod4+Comma exec swaymsg '[app_id="$social-id"] scratchpad show' \
                  || $social \
                  && sleep .1 && swaymsg '[app_id="$social-id"] $social-resize'

        # ^-- resize again, case moving to different output
      '';

    };

  };

  security.pam.services.swaylock = { };

}
