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
          postNew = ''
            notmuch tag +skip-inbox -- 'folder:andrea.maria.piana@gmail.com/skip-inbox'
          '';
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
          extraConfig = ''
            # Sent mail
            set record = "+Sent"

            # Drafts
            set postponed = "+Drafts"

            # Trash
            set trash = "+Trash"

            # Set the mailbox type (Maildir)
            set mbox_type = Maildir

            set editor = "neovide --no-fork";

            set use_threads=threads
            set sort=last-date
            set sort_aux=date

            set record = /dev/null

            bind index n next-entry
            bind index e previous-entry
            bind index o select-entry
            bind pager y exit

            set sidebar_visible = yes
            set sidebar_new_mail_only = no
            set sidebar_next_new_wrap = yes
            set sidebar_next_wrap = yes

            bind index \t sidebar-next
            bind index l sidebar-open
            bind index \Cn sidebar-next
            bind index \Ce sidebar-prev

            color normal		default default             # default colours
            color index		brightblue default ~N       # new messages
            color index		red default ~F              # flagged messages
            color index		blue default ~T             # tagged messages
            color index		brightred default ~D        # deleted messages
            color body		brightgreen default         (https?|ftp)://[\-\.+,/%~_:?&=\#a-zA-Z0-9]+  # links
            color body		brightgreen default         [\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+          # email-addresses
            color attachment	magenta default             # attachments
            color signature		brightwhite default         # sigs
            color search		brightred black             # highlight results

            color indicator		black cyan                  # currently highlighted message
            color error		red default                 # error messages
            color status		white brightblack           # status line
            color tree		white default               # thread tree arrows
            color tilde		cyan default                # blank line padding

            color hdrdefault	brightblue default          # default headers
            color header		cyan default "^From:"
            color header	 	cyan default "^Subject:"

            color quoted		cyan default                # quote colours
            color quoted1		brightcyan default
            color quoted2		blue default
            color quoted3		green default
            color quoted4		yellow default
            color quoted5		red default
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
        notmuch = {
          enable = true;
          neomutt.virtualMailboxes = [
            {
              name = "inbox";
              query = "not tag:spam and not tag:skip-inbox and date:6month..";
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
