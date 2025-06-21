{ pkgs, config, ... }:
{
  users.users.cammellos.packages = with pkgs; [
    libsecret
    gmailctl
  ];

  home-manager.users.cammellos = {

    systemd.user.services.mbsync = {
      Unit = {
        Description = "Run mbsync to sync mail";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.isync}/bin/mbsync -a";
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

    programs = {
      neomutt = {
        enable = true;
      };
      mbsync = {
        enable = true;
      };
      msmtp.enable = true;
      notmuch = {
        enable = true;
        hooks = {
          preNew = "mbsync --all";
        };
      };
    };

    accounts.email = {
      accounts."andrea.maria.piana@gmail.com" = {
        address = "andrea.maria.piana@gmail.com";
        imap.host = "imap.gmail.com";
        neomutt = {
          enable = true;
          extraConfig = ''
            # Set the root of your mail
            set folder = "~/Maildir/andrea.maria.piana@gmail.com"

            # Set inbox (relative to `folder`)
            set spoolfile = "+Inbox"

            # Sent mail
            set record = "+Sent"

            # Drafts
            set postponed = "+Drafts"

            # Trash
            set trash = "+Trash"

            # Set the mailbox type (Maildir)
            set mbox_type = Maildir
          '';
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
        notmuch.enable = true;
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
