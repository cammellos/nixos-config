{ pkgs, config, inputs, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    libsecret
    gmailctl
  ];

  home-manager.users.cammellos = {

    systemd.user.services.mbsync = {
      Unit = {
        Description = "Run notmuch to sync mail";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.notmuch}/bin/notmuch new";
      };
    };

    systemd.user.timers.mbsync = {
      Unit = {
        Description = "Run mbsync every 2 minutes";
      };
      Timer = {
        OnBootSec = "2min";
        OnUnitActiveSec = "2min";
        Persistent = true;
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };


    home.packages = with pkgs; [ neomutt ];
    programs = {
      neomutt = {
        enable = true;
        package = inputs.neomutt-custom.packages.${pkgs.system}.default;
      };
      mbsync = {
        enable = true;
      };
      msmtp.enable = true;
      notmuch = {
        enable = true;
        hooks = {
          preNew = ''
            mbsync --all
          '';
          postNew = builtins.readFile ./config/notmuch-post-new.sh;
        };
      };
    };

    accounts.email = {
      accounts."andrea.maria.piana@gmail.com" = {
        address = "andrea.maria.piana@gmail.com";
        imap.host = "imap.gmail.com";
        neomutt = {
          enable = true;
          showDefaultMailbox = false;
          extraConfig = builtins.readFile ./config/muttrc;
        };
        mbsync = {
          enable = true;
          create = "maildir";
          extraConfig = {
            channel = {
              CopyArrivalDate = "yes";
            };
          };
        };
        msmtp.enable = true;
        notmuch = {
          enable = true;
          neomutt.virtualMailboxes = [
            {
              name = "inbox";
              query = "not tag:spam and (tag:Sent or not tag:skip-inbox) and date:6month..";
            }
          ];

        };
        primary = true;
        realName = "Andrea Maria Piana";
        passwordCommand = "secret-tool lookup 'andrea.maria.piana@gmail.com' password";
        smtp = {
          host = "smtp.gmail.com";
        };
        userName = "andrea.maria.piana@gmail.com";
      };
    };
  };
}
