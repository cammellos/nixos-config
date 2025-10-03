{ config, pkgs, ... }:
let
  background-image = ./background/calvin-and-hobbes.png;
  lock-image = ./background/trout.jpeg;
  browser = "librewolf";
  keepass = "org.keepassxc.KeePassXC";
  media_player = "tidal-hifi";

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
  modifier = "Mod4";
  menu = "${pkgs.rofi-wayland}/bin/rofi -combi-modi window,drun -show combi";
  keybindings = ''
    bindsym ${modifier}+Return exec sh -c 'random_id=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 8); echo "launch env NVIM_SOCKET=/tmp/nvim_$random_id.socket nvim -c terminal --listen /tmp/nvim_$random_id.socket" | kitty --session -'
    bindsym ${modifier}+Space exec "${menu}";

    bindsym ${modifier}+Period fullscreen toggle;
    bindsym ${modifier}+Shift+space floating toggle;

    # simulate command+c/v/t
    bindsym ${modifier}+c exec ydotool key 29:1 46:1 46:0 29:0;
    bindsym ${modifier}+v exec ydotool key 29:1 42:1 47:1 47:0 42:0 29:0;
    bindsym ${modifier}+w exec ydotool key 29:1 17:1 17:0 29:0;

    bindsym ${modifier}+a workspace ${workspace_0};
    bindsym ${modifier}+s exec swaymsg workspace ${workspace_1}; exec --no-startup-id "pgrep ${browser} || exec ${browser}";
    bindsym ${modifier}+h workspace ${workspace_2};
    #"${modifier}+t workspace ${workspace_3};
    bindsym ${modifier}+g workspace ${workspace_4};
    bindsym ${modifier}+u workspace ${workspace_6};
    bindsym ${modifier}+p workspace ${workspace_7};
    bindsym ${modifier}+Semicolon workspace ${workspace_8};
    bindsym ${modifier}+i exec swaymsg workspace ${workspace_9}; exec "pgrep ${media_player} || exec ${media_player}";

    bindsym ${modifier}+Shift+a move container to workspace ${workspace_0};
    bindsym ${modifier}+Shift+s move container to workspace ${workspace_1};
    bindsym ${modifier}+Shift+h move container to workspace ${workspace_2};
    bindsym ${modifier}+Shift+g move container to workspace ${workspace_4};
    bindsym ${modifier}+Shift+y move container to workspace ${workspace_5};
    bindsym ${modifier}+Shift+u move container to workspace ${workspace_6};
    bindsym ${modifier}+Shift+p move container to workspace ${workspace_7};
    bindsym ${modifier}+Shift+Semicolon move container to workspace ${workspace_8};
    bindsym ${modifier}+Shift+i move container to workspace ${workspace_9};

    bindsym ${modifier}+q kill;

    bindsym ${modifier}+n workspace prev;
    bindsym ${modifier}+e workspace next;
    bindsym ${modifier}+Tab exec ${pkgs.rofi-wayland}/bin/rofi -show window -show-icons;

    bindsym ${modifier}+2 exec playerctl play-pause;
    bindsym ${modifier}+3 exec playerctl previous;
    bindsym ${modifier}+4 exec playerctl next;

    # show existing or start new dropdown terminal
    bindsym Mod4+Comma exec swaymsg '[app_id="$social-id"] scratchpad show' \
      || $social \
      && sleep .1 && swaymsg '[app_id="$social-id"] $social-resize'
  '';

in
{
  # so it doesn't interfere
  services.logind.lidSwitch = "ignore";
  home-manager.users.cammellos = {
    home = {
      pointerCursor = {
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 22;
      };
      file = {
        ".local/bin/reset-sway-mode.sh".source = ./config/reset-sway-mode.sh;
      };
    };

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

      config = {

        seat = {
          "*" = {
            xcursor_theme = "Bibata-Modern-Ice 22";
          };
        };

        workspaceAutoBackAndForth = true;

        focus = {
          followMouse = "yes";
        };

        window = {
          border = 0;
          titlebar = false;
        };
        floating.titlebar = false;

        inherit modifier;
        keybindings = { };
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
          "7504:24868:Ultimate_Gadget_Laboratories_UHK_60_v2" = {
            xkb_layout = "us";
            xkb_variant = "workman-p";
          };
          "1:1:AT_Translated_Set_2_keyboard" = {
            xkb_layout = "us";
            xkb_variant = "workman-p";
          };

        };

        startup = [
          { command = "${pkgs.networkmanagerapplet}/bin/nm-applet"; }
          { command = "${pkgs.pasystray}/bin/pasystray"; }
          { command = "${pkgs.dropbox}/bin/dropbox"; }
          { command = "${pkgs.conky}/bin/conky"; }
          { command = "/home/cammellos/.local/bin/reset-sway-mode.sh"; }
          { command = "XDG_CURRENT_DESKTOP=sway"; }
          { command = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd --all"; }
          {
            command = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP=sway";
          }
          {
            command = "${pkgs.keepassxc}/bin/keepassxc ~/Dropbox/passwords.kdbx";
          }
        ];
        fonts = {
          names = [ "JetBrainsMono Nerd Font Mono Bold" ];
          size = 10.0;
        };
        output."*".bg = "${background-image} fill";
      };
      extraConfig = ''

                ${keybindings}
                # Watch closed laptop lid
                set $laptop eDP-1
                bindswitch --reload --locked lid:on output $laptop disable
                bindswitch --reload --locked lid:off output $laptop enable

                assign [app_id="${browser}"] workspace ${workspace_1}
                assign [class="steam"] workspace ${workspace_4}
                for_window [class="steam"] inhibit_idle fullscreen

                assign [app_id="${media_player}"] workspace ${workspace_9}
                for_window [class="mtgo.exe"] floating enable
                for_window [class="Godot"] floating enable
                for_window [app_id="${keepass}"] floating enable
                for_window [class="qemu-system-x86_64-wrapped"] fullscreen enable
                for_window [app_id="neovide"] {
                  floating enable
                  $social-resize
                  move to scratchpad
                  scratchpad show
                }

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

                mode "$social-id" {
                  ${keybindings}
                  bindsym ${modifier}+y exec ydotool key 29:1 42:1 15:1 15:0 42:0 29:0;
                  bindsym ${modifier}+o exec ydotool key 29:1 15:1 15:0 29:0;

                  # open new chatgpt chat
                  bindsym ${modifier}+t exec ydotool key 29:1 42:1 24:1 24:0 42:0 29:0;

                  # search with slash
                  bindsym ${modifier}+slash exec ydotool key 29:1 37:1 37:0 29:0;
                }

                mode "kitty" {
                  bindsym ${modifier}+o exec ydotool key 51:1 24:1 24:0 51:0;
                  bindsym ${modifier}+y exec ydotool key 51:1 21:1 21:0 51:0;
                  bindsym ${modifier}+t exec ydotool key 51:1 20:1 20:0 51:0;

                  ${keybindings}
                }

                mode "nvim" {
                  bindsym ${modifier}+o exec ydotool key 51:1 24:1 24:0 51:0;
                  bindsym ${modifier}+y exec ydotool key 51:1 21:1 21:0 51:0;
                  bindsym ${modifier}+t exec ydotool key 51:1 20:1 20:0 51:0;

                  ${keybindings}
                }

                mode "librewolf" {
                  bindsym ${modifier}+t exec ydotool key 29:1 20:1 20:0 29:0;
                  bindsym ${modifier}+y exec ydotool key 29:1 42:1 15:1 15:0 42:0 29:0;
                  bindsym ${modifier}+o exec ydotool key 29:1 15:1 15:0 29:0;

                  # bar
                  bindsym ${modifier}+l exec ydotool key 29:1 38:1 38:0 29:0;

                  # search with slash
                  bindsym ${modifier}+slash exec ydotool key 29:1 33:1 33:0 29:0;

                  ${keybindings}
                }


        # ^-- resize again, case moving to different output
      '';

    };

  };

  security.pam.services.swaylock = { };

}
